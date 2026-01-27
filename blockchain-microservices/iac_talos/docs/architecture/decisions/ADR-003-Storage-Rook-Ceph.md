# ADR-003: Rook-Ceph comme solution de stockage

## Contexte

Besoin de stockage persistant avec réplication pour PostgreSQL sur Kubernetes.

## Options considérées

### Option 1: Longhorn
**Avantages:**
- Simple à installer
- UI graphique
- Backup S3 intégré

**Inconvénients:**
- Nécessite extensions Talos (iscsi-tools)
- Problèmes réseau avec Factory Images
- CNCF Incubating (moins mature)

### Option 2: Rook-Ceph
**Avantages:**
- CNCF Graduated (seul projet stockage)
- Production-ready (Red Hat, banques)
- Multi-protocole (block, file, object)
- Compatible Talos vanilla

**Inconvénients:**
- Plus complexe
- Consomme plus de ressources
- Courbe d'apprentissage

### Option 3: OpenEBS
**Avantages:**
- Multi-engine flexible

**Inconvénients:**
- CNCF Sandbox (moins mature)
- Documentation limitée

### Option 4: local-path-provisioner
**Avantages:**
- Ultra simple

**Inconvénients:**
- Pas de réplication
- Pas production-ready

## Décision

**Rook-Ceph**

**Raisons:**
1. CNCF Graduated = standard industrie
2. Production-ready = compétence valorisable
3. Compatible Talos vanilla = pas de workaround
4. Multi-protocole = évolutif
5. Haute disponibilité = réplication native

## Conséquences

### Positives
- Stockage distribué et répliqué
- Dynamic provisioning opérationnel
- Compétence demandée en entreprise
- Évolutif (block → file → object)

### Trade-offs acceptés
- Workers augmentés: 2 vCPU/4GB → 6 vCPU/12GB
- Complexité opérationnelle accrue
- Temps installation: 2h vs 5min (local-path)

## Métriques de validation

- Cluster Ceph: HEALTH_OK
- Dynamic provisioning: PVC → Bound < 10s
- Réplication: 2x (size=2, min_size=1)
- Performance: Latence < 10ms

## Références

- [Rook Documentation](https://rook.io/docs/rook/latest/)
- [Ceph Documentation](https://docs.ceph.com/)
- [CNCF Projects](https://www.cncf.io/projects/)

## Date

2026-01-27

## Statut

Accepté et implémenté
