# Blockchain Microservices Platform

Building a production-grade distributed system with microservices architecture.

## Possible Use Cases (beyond cryptocurrency)

### Cybersecurity
- Decentralized identity (DID)
- Immutable audit logs
- Tamper detection & verification

### Supply Chain
- End-to-end traceability
- Integrity enforcement across actors

### Healthcare
- Secure medical data lineage
- Auditability and compliance tracking

### Document Certification
- Diplomas, contracts, legal proofs
- Timestamping and immutability

### IoT
- Secure device authentication
- Distributed registry for trusted events

### Enterprise Information Systems
- Internal consensus system
- Immutable logging layer
- Verifiable workflows

---

## Stack

Rust · Kubernetes · PostgreSQL · RabbitMQ · Terraform

---

## Current Phase

🟡 Architecture & Design (50% complete)

### Completed
- [x] Architecture Decision Records (3 ADRs)
  - [ADR-001: Backend Language (Rust)](./docs/architecture/decisions/ADR_Language.md)
  - [ADR-002: Database (PostgreSQL)](./docs/architecture/decisions/ADR_DB.md)
  - [ADR-003: Message Broker (RabbitMQ)](./docs/architecture/decisions/ADR_Message_Broker.md)
- [x] Database schema design
  - 2 tables: `blocks`, `transactions`
  - Immutability enforced via triggers
  - [View schema](./database/schema.sql)

### In Progress
- [ ] API contracts (OpenAPI)
- [ ] Dependency graph (DAG)

### Next Steps
- Define REST endpoints for 3 microservices (API Gateway, Miner, Node)
- Create deployment dependency graph
- Begin infrastructure setup (Proxmox + Talos)

---

## Architecture Overview

### Microservices

1. **API Gateway** - Authentication (JWT), request routing
2. **Miner Service** - Proof of Work mining (SHA-256)
3. **Node Service** - Block validation and storage

### Communication

- **Sync**: REST APIs between services
- **Async**: RabbitMQ for transaction processing
  - Queue: `transaction.pending`
  - Queue: `block.mined`

### Storage

- **PostgreSQL**: Blocks and transactions (ACID guarantees)
- **Redis** (planned): Caching layer

---

## Documentation

- [`/docs/architecture`](./docs/architecture/) - Design decisions and cross-cutting concerns
- [`/docs/journal`](./docs/journal/) - Development log and methodology
- [`/database`](./database/) - Database schema and migrations

---

## Getting Started

**Note:** This project is currently in the design phase. Implementation will begin after architecture finalization.

### Prerequisites (for future implementation)
- Kubernetes cluster (Talos)
- PostgreSQL 16+
- RabbitMQ 3.x
- Terraform 1.x

---

## Learning Resources

This project follows industry best practices:
- [The Twelve-Factor App](https://12factor.net/)
- [Domain-Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [PostgreSQL Best Practices](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [ADR Templates](https://adr.github.io/)

---

## Progress Tracking

| Phase | Status | Completion |
|-------|--------|------------|
| Architecture & Design | 🟡 In Progress | 50% |
| Infrastructure Setup |  Not Started | 0% |
| Development | Not Started | 0% |
| CI/CD | Not Started | 0% |
| Observability | Not Started | 0% |

---

## License

This is a learning project - no license specified yet.
