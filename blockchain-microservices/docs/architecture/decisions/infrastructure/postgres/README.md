# PostgreSQL Deployment

Production-ready PostgreSQL StatefulSet avec stockage persistant Rook-Ceph.

## Déploiement
```bash
# 1. Créer le namespace
kubectl apply -f namespace.yaml

# 2. Créer le secret
kubectl apply -f secret.yaml

# 3. Déployer PostgreSQL
kubectl apply -f statefulset.yaml
```

## Sécurité

Ce déploiement respecte les **Pod Security Standards** Kubernetes 1.25+ :

- ✅ `runAsNonRoot: true` (UID 999)
- ✅ `allowPrivilegeEscalation: false`
- ✅ Capabilities dropped (`drop: [ALL]`)
- ✅ Seccomp profile RuntimeDefault

Voir [ADR-005](../../docs/architecture/decisions/infrastructure/ADR-005-Pod-Security-Standards.md) pour détails.

## Configuration

- **Image:** `postgres:16`
- **Storage:** 10Gi (Rook-Ceph `ceph-block`)
- **Database:** `blockchain_db`
- **Port:** 5432

## Validation
```bash
# Vérifier le Pod
kubectl get pods -n blockchain

# Vérifier le PVC
kubectl get pvc -n blockchain

# Se connecter
kubectl exec -it postgres-0 -n blockchain -- psql -U postgres -d blockchain_db
```

## Troubleshooting
```bash
# Logs
kubectl logs postgres-0 -n blockchain

# Events
kubectl get events -n blockchain --sort-by='.lastTimestamp'

# Describe
kubectl describe pod postgres-0 -n blockchain
```