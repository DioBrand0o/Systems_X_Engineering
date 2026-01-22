# Database Schema

Schéma PostgreSQL pour la blockchain.

## Fichier

**`schema.sql`** - Schéma complet de la base de données

## Contenu

### Tables
- **blocks** - Blocs de la blockchain (block_hash, previous_hash, nonce, difficulty)
- **transactions** - Transactions associées aux blocs (tx_hash, sender, recipient, amount)

### Contraintes
- **CHECK** - Validation de format (hash SHA-256 hexadécimal 64 caractères)
- **FOREIGN KEY** - Relations entre transactions et blocs
- **ON DELETE RESTRICT** - Protection contre suppression accidentelle

### Triggers
- **Immuabilité** - Empêche toute suppression de blocs ou de transactions confirmées
- Garantit l'intégrité de la blockchain

### Vues
- **block_stats** - Statistiques agrégées par bloc
- **recent_blocks** - 10 derniers blocs minés

### Sécurité
- **Roles PostgreSQL** - Principe du moindre privilège (SELECT/INSERT uniquement)
- Les credentials sont gérés via Vault/Sealed Secrets (pas hardcodés)

## Déploiement

```bash
# Créer la base de données
createdb blockchain_db

# Appliquer le schéma
psql -U postgres -d blockchain_db -f schema.sql
```

## Références

- [PostgreSQL Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [ADR-002: Choix de PostgreSQL](../docs/architecture/decisions/ADR_DB.md)
