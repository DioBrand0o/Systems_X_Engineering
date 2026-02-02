# ADR-006: Accès ArgoCD via NodePort

## Contexte

ArgoCD est déployé sur le cluster Kubernetes et nécessite un accès depuis le poste de développement local (même réseau xxxxxxxxx).

Configuration initiale problématique :
- Type: LoadBalancer
- IP: xxx xx xx xx (hors réseau Proxmox)
- Cilium L2 LoadBalancer non configuré

## Options considérées

### Option 1: LoadBalancer (Cilium L2)
**Avantages:**
- IP dédiée stable
- Production-ready

**Inconvénients:**
- Nécessite configuration Cilium L2 Announcement
- CiliumLoadBalancerIPPool manquant
- Plus complexe pour un accès local uniquement

### Option 2: NodePort
**Avantages:**
- Simple et direct
- Pas de dépendance externe (Cilium L2)
- Fonctionne immédiatement (firewall Talos inactif)
- Accès via n'importe quel node worker

**Inconvénients:**
- Port aléatoire (30241/30824)
- pas d'ip propre 

### Option 3: Port-Forward
**Avantages:**
- Très simple

**Inconvénients:**
- (1 terminal par service)
- Nécessite kubectl actif en permanence

## Décision

**NodePort**

**Raisons:**
1. Accès local uniquement (pas d'exposition internet)
2. Firewall Talos désactivé par défaut (pas de blocage)
3. Simplicité > complexité pour un homelab
4. Évite la configuration Cilium L2 pas le moment 

## Configuration Appliquée

**Service ArgoCD:**
```yaml
server:
  service:
    type: NodePort
    # Ports assignés automatiquement:
    # - HTTP: 30241
    # - HTTPS: 30824
```

**Accès:**
- HTTP: http://10.10.0.150:30241 (ou 10.10.0.151:30241)
- HTTPS: https://10.10.0.150:30824 (certificat auto-signé) pas fait de test

**Credentials:**
```bash
# Username: admin
# Password:
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
```

## Conséquences

### Positives
- ArgoCD accessible immédiatement
- Pas de configuration réseau additionnelle
- Résilient (fonctionne via worker-0 ou worker-1)

### Trade-offs acceptés
- Port non standard (30241 au lieu de 80/443)
- URL moins "propre" qu'avec LoadBalancer
- Inaccessible si tous les workers tombent

## Évolution Future

**Si besoin d'exposition externe:**
1. Configurer Cilium L2 Announcement
2. Créer CiliumLoadBalancerIPPool (xx xxx xx xx )
3. Passer ArgoCD en type LoadBalancer
4. Voir ADR-004 (Cilium CNI) pour détails

## Références

- [Kubernetes Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
- [ArgoCD Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)

## Date

2026-02-02

## Statut

Accepté et implémenté