# ADR-004: Cilium comme CNI Kubernetes

## Contexte

Besoin d'un plugin réseau (CNI) pour communication entre pods Kubernetes.

## Options considérées

### Option 1: Flannel
**Avantages:**
- Simple à configurer
- Stable et mature
- Léger en ressources
- Overlay VXLAN fonctionnel

**Inconvénients:**
- Pas de network policies L7
- Pas de LoadBalancer intégré
- Pas d'observabilité avancée
- Utilise iptables (moins performant)

### Option 2: Calico
**Avantages:**
- Network policies robustes
- BGP routing
- Mature et adopté

**Inconvénients:**
- Plus complexe que Flannel
- Pas de LoadBalancer L2 natif
- Utilise iptables

### Option 3: Cilium
**Avantages:**
- eBPF natif (bypass iptables = +performance)
- Network policies L3-L7
- LoadBalancer L2 intégré
- Hubble observability (flows network)
- Service mesh ready
- Production-grade (Google, AWS, Azure)

**Inconvénients:**
- Kernel Linux 4.9+ requis
- Plus complexe que Flannel
- Consomme plus de ressources

## Décision

**Cilium (cluster dev-vanilla uniquement)**

**Raisons:**
1. eBPF = performance supérieure vs iptables
2. LoadBalancer L2 = pas besoin de MetalLB
3. Network policies avancées = sécurité renforcée
4. Hubble = visibilité complète du trafic
5. Standard industrie = compétence valorisable

**Note:** Le cluster root utilise Flannel (simplicité prioritaire).

## Conséquences

### Positives
- Performance réseau optimale
- LoadBalancer fonctionnel sans composant additionnel
- Observabilité network flows via Hubble
- Network policies production-ready

### Trade-offs acceptés
- Complexité accrue vs Flannel
- Consommation ressources plus élevée
- Debugging nécessite compréhension eBPF

## Implémentation

**Configuration:**
- Mode: eBPF native
- LoadBalancer: L2 announcement
- Hubble: activé
- IP pool: 10.10.0.70-80 (10 IPs)

**Validation:**
```bash
cilium status
# State: Ok

kubectl get svc -A | grep LoadBalancer
# IPs assignées automatiquement
```

## Références

- [Cilium Documentation](https://docs.cilium.io/)
- [eBPF Overview](https://ebpf.io/)
- [Cilium vs Calico](https://docs.cilium.io/en/stable/intro/)

## Date

2026-01-27

## Statut

Accepté et implémenté (dev-vanilla)
