## Architecture Decisions

Toutes les décisions architecturales sont documentées dans `/docs/architecture/decisions/`:

- [ADR-001: Talos OS](./docs/architecture/decisions/ADR-001-Talos-OS.md) - Pourquoi Talos Linux
- [ADR-002: Terraform](./docs/architecture/decisions/ADR-002-Terraform-IaC.md) - Infrastructure as Code
- [ADR-003: Rook-Ceph](./docs/architecture/decisions/ADR-003-Storage-Rook-Ceph.md) - Solution de stockage

## Deployment Graph

Visualisation de l'ordre de déploiement: [Infrastructure Deployment](./docs/architecture/diagrams/infrastructure-deployment.md)

## Storage - Rook-Ceph

**Statut:** Opérationnel (2026-01-27)

Configuration actuelle:
- Cluster: dev-vanilla (Talos 1.10.5 + K8s 1.33.3)
- Workers: 2 nodes (6 vCPU / 12 GB RAM)
- Monitors: 2 (mon-a, mon-b)
- OSDs: 2 (sur /dev/sdb, 40 GB)
- Réplication: 2x
- StorageClass: ceph-block (default)

Voir [ADR-003](./docs/architecture/decisions/ADR-003-Storage-Rook-Ceph.md) pour détails.
```
