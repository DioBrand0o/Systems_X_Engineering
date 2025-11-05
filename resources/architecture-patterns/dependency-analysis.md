# Dependency Analysis (Analyse des Dépendances)

## Définition
Identifier **dans quel ordre** implémenter des composants en fonction de leurs dépendances.

## Concepts associés
- **Topological Sort** : Tri des dépendances
- **DAG** (Directed Acyclic Graph) : Graphe de dépendances

## Méthode
1. Lister tous les composants
2. Identifier "qui dépend de qui"
3. Créer un graphe de dépendances
4. Déployer dans l'ordre topologique

## Exemple
```
Prometheus → dépend de → RBAC
Donc : RBAC en premier, Prometheus ensuite
```
