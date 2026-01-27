# ADR-004 : Choix de la solution de stockage Kubernetes

## Contexte

Le projet blockchain nécessite du stockage persistant pour PostgreSQL (base de données ACID).

**Besoins identifiés :**
- Block storage (RWO - ReadWriteOnce)
- Dynamic provisioning (pas de création manuelle de PV)
- Réplication des données (haute disponibilité)
- Performance suffisante pour PostgreSQL
- Production-ready (CNCF reconnu)

## Options considérées

### Option 1 : Longhorn (CNCF Incubating)
**Avantages :**
- Simple à installer et configurer
- UI graphique intuitive
- Backup S3 intégré
- Communauté active (Rancher)

**Inconvénients :**
- **Nécessite extensions Talos** (iscsi-tools, util-linux-tools)
- Problèmes réseau rencontrés avec Factory Images
- Moins mature que Rook-Ceph

### Option 2 : Rook-Ceph (CNCF Graduated)
**Avantages :**
- **CNCF Graduated** (seul projet stockage graduated)
- Multi-protocole (block, file, object)
- Très mature et utilisé en production (Red Hat OpenShift)
- Excellente documentation
- Pas besoin d'extensions Talos spécifiques

**Inconvénients :**
- Plus complexe à configurer (CRUSH maps, OSDs)
- **Consomme plus de ressources** (MONs, MGRs, OSDs)
- Courbe d'apprentissage plus longue

### Option 3 : OpenEBS (CNCF Sandbox)
**Avantages :**
- Multi-engine (Jiva, cStor, Mayastor)
- Flexible
- Pas d'extensions Talos requises

**Inconvénients :**
- Moins mature que Rook-Ceph (Sandbox)
- Documentation moins exhaustive

### Option 4 : local-path-provisioner
**Avantages :**
- Ultra simple (2 min installation)
- Léger

**Inconvénients :**
- **Pas de réplication** (données sur 1 seul node)
- **Pas production-ready**

## Décision

**Rook-Ceph (Option 2)**

**Raisons :**
1. **CNCF Graduated** → Standard industrie reconnu
2. **Expérience professionnelle valorisable** → Compétence demandée en entreprise
3. **Production-ready** → Utilisé par Red Hat, Telcos, Banques
4. **Compatible Talos vanilla** → Pas besoin de Factory Images problématiques
5. **Multi-protocole** → Évolutif si besoin de CephFS ou S3 plus tard

## Conséquences

### Positives
- Cluster production-like dans mon homelab
- Compétence Rook-Ceph pour CV/entretiens
- Stockage répliqué et haute disponibilité
- Dynamic provisioning opérationnel

### Trade-offs acceptés
- **Ressources augmentées** : Workers passés de 2 vCPU / 4 GB à 6 vCPU / 12 GB
- **Complexité** : Nécessite compréhension de Ceph (MONs, OSDs, MGRs)
- **Temps d'installation** : 2h vs 5 min pour local-path


```

**Configuration cluster :**
- 2 MONs (monitors Ceph)
- 2 OSDs (Object Storage Daemons sur `/dev/sdb`)
- 1 MGR (manager)
- Réplication : size=2, min_size=1
- StorageClass : `ceph-block` (default)

## Évolution future

**Si passage à 3 workers :**
- Modifier `mon.count: 3` dans values.yaml
- Ajouter 1 OSD automatiquement
- Réplication = 3 (haute disponibilité complète)

**Si besoin de CephFS (ReadWriteMany) :**
- Activer MDS (Metadata Server) dans Helm values
- StorageClass `ceph-filesystem` déjà disponible

## Références

- [Rook Documentation](https://rook.io/docs/rook/latest/)
- [Ceph Documentation](https://docs.ceph.com/)
- [CNCF Graduated Projects](https://www.cncf.io/projects/)
- [Talos Rook Guide](https://www.talos.dev/v1.10/kubernetes-guides/configuration/storage/)

## Date

2026-01-27

## Statut

✅ **Accepté et implémenté**
