# ADR-002: Terraform comme outil Infrastructure as Code

## Contexte

Besoin d'automatiser le déploiement d'infrastructure Kubernetes sur Proxmox.

## Options considérées

### Option 1: Scripts Bash manuels
**Avantages:**
- Simple pour débuter
- Aucune dépendance externe

**Inconvénients:**
- Pas de gestion d'état
- Pas idempotent
- Difficile à maintenir

### Option 2: Ansible
**Avantages:**
- Agentless
- Syntaxe YAML familière
- Bon pour configuration

**Inconvénients:**
- Moins adapté pour infrastructure
- Pas de plan/preview avant application
- State management limité

### Option 3: Terraform
**Avantages:**
- Déclaratif
- State management robuste
- Plan avant apply (preview)
- Multi-provider (Proxmox, Talos, Helm, K8s)
- Modules réutilisables

**Inconvénients:**
- Langage HCL à apprendre
- State file à gérer

### Option 4: Pulumi
**Avantages:**
- Code dans langage classique (Python, Go)
- State management

**Inconvénients:**
- Moins mature que Terraform
- Moins de providers

## Décision

**Terraform**

**Raisons:**
1. Multi-provider couvre tous les besoins (Proxmox + Talos + Helm + K8s)
2. Plan/Apply workflow sécurise les changements
3. Modules permettent réutilisation
4. State tracking évite dérive
5. Standard industrie (compétence valorisable)

## Conséquences

### Positives
- Infrastructure versionnée dans Git
- Reproductibilité garantie
- Preview des changements avant application
- Modules partagés entre environnements

### Trade-offs acceptés
- Apprentissage HCL nécessaire
- State file sensible (credentials)
- Locking requis pour travail en équipe

## Références

- [Terraform Documentation](https://www.terraform.io/docs)
- [Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)

## Date

2026-01-27

## Statut

Accepté
