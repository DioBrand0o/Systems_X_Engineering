-- ============================================
-- SCHÉMA POSTGRESQL POUR BLOCKCHAIN MICROSERVICES
-- ============================================
-- Date: 2024-11-14
-- Description: Schéma de base de données pour une blockchain avec 
--              contraintes d'intégrité et immuabilité garantie par trigger.

-- ============================================
-- TABLE: blocks
-- ============================================
-- Stocke les blocs de la blockchain
-- Chaque bloc contient le hash du bloc précédent (chaînage)

CREATE TABLE blocks (
    id BIGSERIAL PRIMARY KEY,
    
    -- Hash SHA-256 du bloc (identifiant unique)
    block_hash VARCHAR(64) NOT NULL UNIQUE,
    
    -- Hash du bloc précédent (chaînage de la blockchain)
    previous_hash VARCHAR(64) NOT NULL,
    
    -- Nonce utilisé pour le mining (Proof of Work)
    nonce BIGINT NOT NULL,
    
    -- Difficulté du mining (nombre de zéros requis en début de hash)
    difficulty INTEGER NOT NULL CHECK (difficulty > 0),
    
    -- Horodatage de création du bloc
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Identifiant du mineur (optionnel)
    mined_by VARCHAR(255),
    
    -- Contraintes métier : format hexadécimal 64 caractères
    CONSTRAINT valid_hash_format 
        CHECK (block_hash ~ '^[a-fA-F0-9]{64}$'),
    
    CONSTRAINT valid_previous_hash_format 
        CHECK (previous_hash ~ '^[a-fA-F0-9]{64}$')
);

-- Index pour recherche rapide par hash
CREATE INDEX idx_blocks_hash ON blocks(block_hash);

-- Index pour recherche chronologique (blocs récents en premier)
CREATE INDEX idx_blocks_timestamp ON blocks(timestamp DESC);

-- Commentaires sur les colonnes
COMMENT ON TABLE blocks IS 'Stockage des blocs de la blockchain';
COMMENT ON COLUMN blocks.block_hash IS 'Hash SHA-256 unique du bloc (64 caractères hexa)';
COMMENT ON COLUMN blocks.previous_hash IS 'Hash du bloc précédent (chaînage)';
COMMENT ON COLUMN blocks.nonce IS 'Nonce utilisé pour le Proof of Work';
COMMENT ON COLUMN blocks.difficulty IS 'Nombre de zéros requis en début de hash';

-- ============================================
-- TABLE: transactions
-- ============================================
-- Stocke les transactions associées aux blocs

CREATE TABLE transactions (
    id BIGSERIAL PRIMARY KEY,
    
    -- Référence au bloc contenant cette transaction
    block_id BIGINT NOT NULL,
    
    -- Hash unique de la transaction
    tx_hash VARCHAR(64) NOT NULL UNIQUE,
    
    -- Adresse de l'émetteur
    sender VARCHAR(255) NOT NULL,
    
    -- Adresse du destinataire
    recipient VARCHAR(255) NOT NULL,
    
    -- Montant transféré (precision: 8 décimales)
    amount NUMERIC(20, 8) NOT NULL CHECK (amount > 0),
    
    -- Horodatage de la transaction
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Statut de la transaction
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    
    -- Relation avec la table blocks
    -- ON DELETE RESTRICT : empêche la suppression d'un bloc si des transactions existent
    -- (renforce l'immuabilité)
    CONSTRAINT fk_block
        FOREIGN KEY (block_id)
        REFERENCES blocks(id)
        ON DELETE RESTRICT,
    
    -- Contraintes métier
    CONSTRAINT valid_tx_hash_format 
        CHECK (tx_hash ~ '^[a-fA-F0-9]{64}$'),
    
    CONSTRAINT valid_status 
        CHECK (status IN ('pending', 'confirmed', 'failed'))
);

-- Index pour recherche rapide
CREATE INDEX idx_transactions_block ON transactions(block_id);
CREATE INDEX idx_transactions_hash ON transactions(tx_hash);
CREATE INDEX idx_transactions_sender ON transactions(sender);
CREATE INDEX idx_transactions_recipient ON transactions(recipient);
CREATE INDEX idx_transactions_status ON transactions(status);

-- Commentaires sur les colonnes
COMMENT ON TABLE transactions IS 'Transactions associées aux blocs';
COMMENT ON COLUMN transactions.block_id IS 'Référence au bloc contenant cette transaction';
COMMENT ON COLUMN transactions.tx_hash IS 'Hash SHA-256 unique de la transaction';
COMMENT ON COLUMN transactions.amount IS 'Montant transféré (précision: 8 décimales)';
COMMENT ON COLUMN transactions.status IS 'Statut: pending, confirmed, ou failed';

-- ============================================
-- TRIGGER: Immuabilité des blocs
-- ============================================
-- Une blockchain est immuable : les blocs ne peuvent jamais être supprimés
-- Ce trigger empêche toute suppression, même si le bloc est vide

CREATE OR REPLACE FUNCTION prevent_block_deletion()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Blockchain immutability violation: blocks cannot be deleted (block_id: %)', OLD.id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER block_immutability
BEFORE DELETE ON blocks
FOR EACH ROW
EXECUTE FUNCTION prevent_block_deletion();

COMMENT ON FUNCTION prevent_block_deletion() IS 'Garantit l''immuabilité de la blockchain en bloquant toute suppression de blocs';

-- ============================================
-- TRIGGER: Immuabilité des transactions
-- ============================================
-- Les transactions confirmées ne peuvent pas être supprimées

CREATE OR REPLACE FUNCTION prevent_transaction_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status = 'confirmed' THEN
        RAISE EXCEPTION 'Blockchain immutability violation: confirmed transactions cannot be deleted (tx_id: %)', OLD.id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER transaction_immutability
BEFORE DELETE ON transactions
FOR EACH ROW
EXECUTE FUNCTION prevent_transaction_deletion();

COMMENT ON FUNCTION prevent_transaction_deletion() IS 'Empêche la suppression des transactions confirmées';

-- ============================================
-- DONNÉES INITIALES: Genesis Block
-- ============================================
-- Le genesis block est le premier bloc de la blockchain
-- Par convention, son previous_hash pointe vers lui-même

INSERT INTO blocks (
    block_hash, 
    previous_hash, 
    nonce, 
    difficulty, 
    mined_by,
    timestamp
)
VALUES (
    '0000000000000000000000000000000000000000000000000000000000000000',
    '0000000000000000000000000000000000000000000000000000000000000000',
    0,
    1,
    'genesis',
    '2024-01-01 00:00:00+00'
);

COMMENT ON TABLE blocks IS 'Le genesis block (id=1) est le bloc initial de la blockchain';

-- ============================================
-- VUES UTILES (optionnel)
-- ============================================

-- Vue : Statistiques par bloc
CREATE VIEW block_stats AS
SELECT 
    b.id,
    b.block_hash,
    b.difficulty,
    b.timestamp,
    b.mined_by,
    COUNT(t.id) as transaction_count,
    COALESCE(SUM(t.amount), 0) as total_amount
FROM blocks b
LEFT JOIN transactions t ON t.block_id = b.id
GROUP BY b.id, b.block_hash, b.difficulty, b.timestamp, b.mined_by
ORDER BY b.id DESC;

COMMENT ON VIEW block_stats IS 'Statistiques agrégées par bloc (nombre de transactions, montant total)';

-- Vue : Derniers blocs minés
CREATE VIEW recent_blocks AS
SELECT 
    id,
    block_hash,
    previous_hash,
    difficulty,
    timestamp,
    mined_by
FROM blocks
ORDER BY timestamp DESC
LIMIT 10;

COMMENT ON VIEW recent_blocks IS '10 derniers blocs minés';

-- ============================================
-- GRANTS - à adapter selon les roles 
-- ============================================
-- Exemple : créer un role applicatif avec droits limités

-- CREATE ROLE blockchain_app WITH LOGIN PASSWORD 'change_me';
-- GRANT SELECT, INSERT ON blocks, transactions TO blockchain_app;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO blockchain_app;

-- ============================================
-- FIN DU SCHÉMA
-- ============================================
