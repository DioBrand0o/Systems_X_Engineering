# Security-First Design

## Définition
Déployer les composants de sécurité (RBAC, secrets, policies) **avant** les composants applicatifs.

## Principe
Rien ne tourne sans permissions explicites.

## Justification
- Defense in Depth
- Principe du moindre privilège
- Facilite l'audit

## Application
Les composants dépendent du RBAC.

Exemple : Prometheus lit les métriques → il a besoin d'un rôle avant de démarrer.
