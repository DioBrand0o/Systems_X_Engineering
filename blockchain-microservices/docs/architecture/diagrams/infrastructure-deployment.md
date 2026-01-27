# Infrastructure Deployment Graph

## Ordre de déploiement
```mermaid
graph TD
    %% Niveau 0: Hyperviseur
    PVE[Proxmox VE<br/>Hyperviseur]

    %% Niveau 1: VMs
    C0[Controller-0<br/>c0: 10.10.0.140]
    W0[Worker-0<br/>w0: 10.10.0.150]
    W1[Worker-1<br/>w1: 10.10.0.151]

    %% Niveau 2: OS
    TALOS_C0[Talos OS 1.10.5<br/>Kubernetes 1.33.3]
    TALOS_W0[Talos OS 1.10.5<br/>Kubernetes 1.33.3]
    TALOS_W1[Talos OS 1.10.5<br/>Kubernetes 1.33.3]

    %% Niveau 3: CNI
    CILIUM[Cilium CNI<br/>Network Layer]

    %% Niveau 4: Storage
    ROOK[Rook-Ceph<br/>Distributed Storage]

    %% Niveau 5: Applications
    PG[PostgreSQL<br/>Database]
    RMQ[RabbitMQ<br/>Message Broker]

    %% Dependencies
    PVE --> C0
    PVE --> W0
    PVE --> W1

    C0 --> TALOS_C0
    W0 --> TALOS_W0
    W1 --> TALOS_W1

    TALOS_C0 --> CILIUM
    TALOS_W0 --> CILIUM
    TALOS_W1 --> CILIUM

    CILIUM --> ROOK

    ROOK --> PG
    ROOK --> RMQ

    %% Styling
    classDef hypervisor fill:#e1f5ff,stroke:#01579b,stroke-width:2px
    classDef vm fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef os fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef network fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef storage fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef app fill:#f1f8e9,stroke:#558b2f,stroke-width:2px

    class PVE hypervisor
    class C0,W0,W1 vm
    class TALOS_C0,TALOS_W0,TALOS_W1 os
    class CILIUM network
    class ROOK storage
    class PG,RMQ app
```

## Niveaux de déploiement

### Niveau 0: Hyperviseur
**Proxmox VE 8.x**
- Virtualisation hardware
- API pour automation Terraform

### Niveau 1: VMs
**3 nodes Kubernetes**
- 1 controller (c0): Control plane
- 2 workers (w0, w1): Workloads
- Configuration: 6 vCPU / 12 GB RAM / worker
- Disques: 30 GB système + 40 GB storage

### Niveau 2: OS
**Talos Linux 1.10.5**
- OS immutable API-first
- Kubernetes 1.33.3 intégré
- Pas de SSH, configuration déclarative

### Niveau 3: Réseau
**Cilium CNI**
- Network policies eBPF
- LoadBalancer L2
- Hubble observability

### Niveau 4: Stockage
**Rook-Ceph**
- 2 monitors Ceph (mon-a, mon-b)
- 2 OSDs sur /dev/sdb
- StorageClass: ceph-block (default)
- Réplication: 2x

### Niveau 5: Applications
**PostgreSQL et RabbitMQ**
- PostgreSQL: Base de données blockchain
- RabbitMQ: Message broker async

## Temps de déploiement

| Phase | Durée | Outil |
|-------|-------|-------|
| VMs | 3 min | Terraform |
| Talos bootstrap | 2 min | Terraform + Talos provider |
| Cilium install | 1 min | Helm via Terraform |
| Rook-Ceph | 5 min | Helm |
| **Total** | **~11 min** | Automation complète |

## Single Points of Failure

| Composant | SPOF | Mitigation |
|-----------|------|------------|
| Proxmox | OUI | Proxmox cluster (3+ nodes) |
| Controller-0 | OUI | 3 controllers (HA) |
| Rook-Ceph | NON | Réplication 2x |
| Cilium | NON | DaemonSet (tous nodes) |

## Références

- [Talos Installation](https://www.talos.dev/v1.10/introduction/getting-started/)
- [Rook-Ceph Quickstart](https://rook.io/docs/rook/latest/Getting-Started/quickstart/)
