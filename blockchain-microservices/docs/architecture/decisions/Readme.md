# Architecture Decision Records (ADRs)

Documentation des décisions architecturales majeures du projet.

## Format ADR

Chaque ADR suit cette structure :
1. **Contexte** - Pourquoi cette décision est nécessaire
2. **Options considérées** - Alternatives évaluées
3. **Décision** - Choix retenu et justification
4. **Conséquences** - Trade-offs acceptés

## ADRs Créés

### [ADR-001: Langage Backend (Rust)](./ADR_Language.md)
**Décision :** Utiliser Rust pour tous les microservices

**Pourquoi :**
- Sécurité mémoire (ownership model)
- Performance critique pour le mining
- Cohérence avec projet parallèle (do-serverless)

**Alternative écartée :** Go

---

### [ADR-002: Base de Données (PostgreSQL)](./ADR_DB.md)
**Décision :** PostgreSQL pour le stockage blockchain

**Pourquoi :**
- Garanties ACID (critique pour l'intégrité)
- Relations naturelles (blocs → transactions)
- Écosystème Rust mature (SQLx)

**Alternative écartée :** MongoDB

---

### [ADR-003: Message Broker (RabbitMQ)](./ADR_Message_Broker.md)
**Décision :** RabbitMQ pour la communication asynchrone

**Pourquoi :**
- Performance suffisante (30-40K msg/sec)
- Simplicité opérationnelle
- Adapté aux microservices point-à-point

**Alternative écartée :** Kafka

---

## Références

- [ADR Templates](https://adr.github.io/)
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
