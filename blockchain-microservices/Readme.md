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

Architecture & Design (100% complete)

### Completed

#### Architecture Decision Records (ADRs)
- [x] [ADR-001: Backend Language (Rust)](./docs/architecture/decisions/ADR_Language.md)
- [x] [ADR-002: Database (PostgreSQL)](./docs/architecture/decisions/ADR_DB.md)
- [x] [ADR-003: Message Broker (RabbitMQ)](./docs/architecture/decisions/ADR_Message_Broker.md)

#### Data Model
- [x] Database schema design
  - 2 tables: `blocks`, `transactions`
  - Immutability enforced via triggers
  - Security roles (principle of least privilege)
  - [View schema](./database/schema.sql)

#### API Contracts (OpenAPI 3.0)
- [x] [API Gateway specification](./api/api-gateway.yaml) (7 endpoints)
- [x] [Miner Service specification](./api/miner-service.yaml) (3 endpoints)
- [x] [Node Service specification](./api/node-service.yaml) (6 endpoints)

#### Architecture Diagrams
- [x] [Dependency Graph (DAG)](./docs/architecture/diagrams/dependency-graph.md) - Deployment order & SPOF analysis
- [x] [C4 Level 1: System Context](./docs/architecture/diagrams/c4-level1-system-context.md) - External view
- [x] [C4 Level 2: Container Diagram](./docs/architecture/diagrams/c4-level2-container.md) - Internal components

### Next Steps
- Begin infrastructure setup (Proxmox + Talos Kubernetes)
- Implement Rust microservices
- Deploy observability stack (Prometheus/Grafana/Loki)

---

## Architecture Overview

### Microservices

1. **API Gateway** - Authentication (JWT), transaction submission, blockchain queries
2. **Miner Service** - Proof of Work mining (SHA-256), nonce calculation
3. **Node Service** - Block validation, PostgreSQL storage, blockchain exposure

### Communication Patterns

**Asynchronous (Event-Driven):**
```
User → API Gateway → RabbitMQ (transaction.pending)
                   → Miner Service → RabbitMQ (block.mined)
                                   → Node Service → PostgreSQL
```

**Synchronous (Request-Response):**
```
User → API Gateway → Node Service → PostgreSQL (blockchain queries)
```

**Queues:**
- `transaction.pending` - Pending transactions awaiting mining
- `block.mined` - Mined blocks awaiting validation

### Storage

- **PostgreSQL 16+** - Blocks and transactions (ACID guarantees, immutability)
- **RabbitMQ 3.x** - Asynchronous message broker (AMQP)
- **Redis** (planned) - Caching layer

---

## Documentation

- [`/docs/architecture/decisions`](./docs/architecture/decisions/) - Architecture Decision Records (ADRs)
- [`/docs/architecture/diagrams`](./docs/architecture/diagrams/) - C4 diagrams & dependency graph
- [`/docs/journal`](./docs/journal/) - Development log and methodology
- [`/database`](./database/) - Database schema and migrations
- [`/api`](./api/) - OpenAPI specifications (contracts)

---

## Getting Started

**Note:** This project is currently in the design phase. Implementation will begin with infrastructure setup.

### Prerequisites (for future implementation)
- Kubernetes cluster (Talos Linux)
- PostgreSQL 16+
- RabbitMQ 3.x
- Terraform 1.x
- Rust toolchain

---

## Learning Resources

This project follows industry best practices:
- [The Twelve-Factor App](https://12factor.net/)
- [Domain-Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [PostgreSQL Best Practices](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [C4 Model](https://c4model.com/)
- [OpenAPI Specification](https://swagger.io/specification/)
- [ADR Templates](https://adr.github.io/)

---

## Progress Tracking

| Phase | Status | Completion |
|-------|--------|------------|
| Architecture & Design | ✅ Complete | 100% |
| Infrastructure Setup | ⏳ Not Started | 0% |
| Development | ⏳ Not Started | 0% |
| CI/CD | ⏳ Not Started | 0% |
| Observability | ⏳ Not Started | 0% |

---

## Project Structure
```
blockchain-microservices/
├── api/                    # OpenAPI contracts
│   ├── api-gateway.yaml
│   ├── miner-service.yaml
│   └── node-service.yaml
├── database/               # PostgreSQL schema
│   └── schema.sql
├── docs/
│   ├── architecture/
│   │   ├── decisions/      # ADRs
│   │   └── diagrams/       # C4 & DAG
│   └── journal/            # Development log
└── README.md
```

---

## License

This is a learning project - no license specified yet.
