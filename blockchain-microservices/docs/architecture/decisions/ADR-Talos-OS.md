# ADR-001: Choix de Talos Linux comme OS Kubernetes

## Contexte

Besoin d'un système d'exploitation pour nodes Kubernetes avec haute sécurité et gestion simplifiée.

## Options considérées

### Option 1: Ubuntu Server + kubeadm
**Avantages:**
- Documentation abondante
- Familier pour la plupart des ops
- Écosystème riche

**Inconvénients:**
- Configuration manuelle complexe
- Surface d'attaque élevée (SSH, shell)
- Drift de configuration possible
- Maintenance lourde

### Option 2: Talos Linux
**Avantages:**
- OS immutable (pas de drift)
- API-first (pas de SSH)
- Surface d'attaque minimale
- Upgrades atomiques avec rollback
- Conçu uniquement pour Kubernetes

**Inconvénients:**
- Courbe d'apprentissage
- Debugging différent (pas de shell)
- Moins de ressources communautaires

### Option 3: Flatcar Container Linux
**Avantages:**
- Immutable
- Auto-updates
- Léger

**Inconvénients:**
- Nécessite ignition configs complexes
- Moins orienté Kubernetes que Talos

## Décision

**Talos Linux**

**Raisons:**
1. Immutabilité élimine le drift de configuration
2. Pas de SSH réduit drastiquement la surface d'attaque
3. API déclarative s'intègre bien avec Terraform
4. Upgrades atomiques sans downtime
5. Spécialisé Kubernetes (pas de services inutiles)

## Conséquences

### Positives
- Infrastructure reproductible à 100%
- Sécurité renforcée (pas de shell, pas de SSH)
- Gestion via API (automation friendly)
- Upgrades sans risque (rollback automatique)

### Trade-offs acceptés
- Debugging nécessite apprentissage de talosctl
- Moins de flexibilité qu'un OS général
- Dépendance à l'API Talos pour toute modification

## Références

- [Talos Documentation](https://www.talos.dev/)
- [CNCF Security Whitepaper](https://www.cncf.io/wp-content/uploads/2020/08/CNCF_Kubernetes_Security_Whitepaper_Aug2020.pdf)

## Date

2026-01-27

## Statut

Accepté
