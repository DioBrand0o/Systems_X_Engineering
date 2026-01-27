# Architecture Decision Records (ADRs)

Documentation des décisions architecturales majeures du projet.

## Format ADR

Chaque ADR suit cette structure :
1. **Contexte** - Pourquoi cette décision est nécessaire
2. **Options considérées** - Alternatives évaluées
3. **Décision** - Choix retenu et justification
4. **Conséquences** - Trade-offs acceptés

---

## ADRs par Domaine

### 📦 Application

- [ADR-001: Backend Language (Rust)](./application/ADR-001-Backend-Language.md)
- [ADR-002: Database (PostgreSQL)](./application/ADR-002-Database.md)
- [ADR-003: Message Broker (RabbitMQ)](./application/ADR-003-Message-Broker.md)

### 🏗️ Infrastructure

- [ADR-001: Kubernetes OS (Talos Linux)](./infrastructure/ADR-001-Talos-OS.md)
- [ADR-002: IaC Tool (Terraform)](./infrastructure/ADR-002-Terraform-IaC.md)
- [ADR-003: Storage (Rook-Ceph)](./infrastructure/ADR-003-Storage-Rook-Ceph.md)
- [ADR-004: Networking (Cilium CNI)](./infrastructure/ADR-004-Cilium-CNI.md)

---

## Références

- [ADR Templates](https://adr.github.io/)
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)