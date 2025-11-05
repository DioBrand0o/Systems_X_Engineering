# RBAC Design - Personas

## Personas identifiés

| Persona | Namespaces | Responsabilités |
|---------|-----------|-----------------|
| **Platform Admin** | `*` (tous) | Gestion infrastructure globale |
| **Application Developer** | `dev-*`, `staging-*` | Déploiement applications |
| **Read-Only Operator** | `*` (tous) | Consultation métriques/logs |
| **Security Auditor** | `*` (tous) | Audit conformité |

## Prochaine étape
Créer les ClusterRoles + RoleBindings Kubernetes.

## Statut
🟡 Draft - Pas encore implémenté
