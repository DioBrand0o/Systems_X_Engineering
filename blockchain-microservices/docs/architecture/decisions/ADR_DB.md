# ADR-002 : Choix de la base de données

## Contexte
Ce projet blockchain nécessite de stocker des blocs chaînés 
et des transactions. Les besoins sont : requêtes rapides sur les 
transactions, intégrité des données (ACID), et relations entre 
blocs et transactions.
## Options considérées
PostgreSQL (relationnel)
MongoDB (NoSQL document)

### Option 1 : PostgreSQL
**Avantages :**
- gere les requete complexe 
- ACID integité des donneé
- Relation entre les tables 
...
**Inconvénients :**
Demande Migration pour Scalabilité horizontal
...

### Option 2 : MongoDB
**Avantages :**
- scalable horisontable plus facile 
- schema egalment flexible 
- accept json en bloc
...
**Inconvénients :**
- pas de transcation ACID 
...
## Décision
1. ACID critique pour l'intégrité blockchain
2. Relations naturelles entre blocs et transactions
3. Écosystème Rust mature st un facteur clef en plus de ca grande communoté 

## Conséquences
**Positives :**
- Requêtes SQL complexes facilitées
- Intégrité garantie
...
**Trade-offs acceptés :**
...
- Scalabilité horizontale plus complexe que MongoDB
- Schéma plus rigide (migrations nécessaires)
