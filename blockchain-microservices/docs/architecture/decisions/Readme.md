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

---

### [ADR-004: Talos OS](./infrastructure/ADR-001-Talos-OS.md)
**Décision :** Talos Linux comme OS Kubernetes

**Pourquoi :**
- Immutabilité (pas de drift de configuration)
- API-first (pas de SSH)
- Surface d'attaque minimale
- Spécialisé Kubernetes

**Alternative écartée :** Ubuntu Server + kubeadm

---

### [ADR-005: Terraform IaC](./infrastructure/ADR-002-Terraform-IaC.md)
**Décision :** Terraform pour automatisation infrastructure

**Pourquoi :**
- Multi-provider (Proxmox, Talos, Helm, K8s)
- Plan/Apply workflow sécurisé
- State management robuste

**Alternative écartée :** Ansible

---

### [ADR-006: Rook-Ceph Storage](./infrastructure/ADR-003-Storage-Rook-Ceph.md)
**Décision :** Rook-Ceph pour stockage persistant

**Pourquoi :**
- CNCF Graduated (seul projet stockage)
- Production-ready
- Compatible Talos vanilla

**Alternative écartée :** Longhorn

---

### [ADR-007: Cilium CNI](./infrastructure/ADR-004-Cilium-CNI.md)
**Décision :** Cilium comme plugin réseau Kubernetes

**Pourquoi :**
- eBPF natif (performance supérieure)
- LoadBalancer L2 intégré
- Network policies L3-L7

**Alternative écartée :** Flannel, Calico



## Références

- [ADR Templates](https://adr.github.io/)
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
