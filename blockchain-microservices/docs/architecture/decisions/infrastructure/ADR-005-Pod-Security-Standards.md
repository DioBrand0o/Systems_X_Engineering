# ADR-005: Pod Security Standards pour PostgreSQL

## Contexte

Kubernetes 1.25+ applique des **PodSecurity Standards** strictes qui bloquent les Pods sans `securityContext` approprié.

Le déploiement initial de PostgreSQL échouait avec ce warning:
```
Warning: would violate PodSecurity "restricted:latest": 
allowPrivilegeEscalation != false, 
unrestricted capabilities, 
runAsNonRoot != true, 
seccompProfile
```

## Options considérées

### Option 1: Désactiver PodSecurity pour le namespace
**Avantages:**
- Rapide (1 ligne de configuration)
- Pas de modification des manifests

**Inconvénients:**
- Non production-ready
- Surface d'attaque élevée
- Mauvaise pratique sécurité

### Option 2: Ajouter securityContext (Production-Ready)
**Avantages:**
- Conforme aux standards Kubernetes
- Surface d'attaque minimale
- Production-ready dès le début
- Principe du moindre privilège

**Inconvénients:**
- Plus complexe
- Nécessite compréhension des UIDs/GIDs

## Décision

**Option 2: SecurityContext Production-Ready**

**Configuration appliquée:**
```yaml
# Pod-level
securityContext:
  runAsNonRoot: true
  runAsUser: 999           # UID PostgreSQL officiel
  fsGroup: 999
  seccompProfile:
    type: RuntimeDefault

# Container-level
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
```

**Raisons:**
1. Conformité PodSecurity Standards Kubernetes
2. Surface d'attaque minimale (capabilities dropped)
3. UID non-root (999 = utilisateur postgres officiel)

## Conséquences

### Positives
- Pod conforme aux standards Kubernetes 1.25+
- Sécurité renforcée (non-root, no privilege escalation)
- Production-ready immédiatement
- Pas de refactoring de sécurité plus tard

### Trade-offs acceptés
- Configuration plus complexe
- PGDATA modifié en `/var/lib/postgresql/data/pgdata` (évite conflit lost+found)
- Nécessite compréhension des securityContext

## Références

- [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [PostgreSQL Container Best Practices](https://github.com/docker-library/docs/blob/master/postgres/README.md#pgdata)
- [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes)

## Date

2026-01-30

## Statut

Accepté et implémenté