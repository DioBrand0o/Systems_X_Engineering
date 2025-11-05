# Journal de Conception - Méthodologie

## 🎯 Contexte
J'en suis à la conception du projet. Il est important pour moi de comprendre comment réfléchir et d'acquérir une méthodologie, pour utiliser les outils avec logique, efficacité et efficience.

---

## 🔍 À la Recherche de la Méthodologie

### Approche pragmatique et empirique
Avant toute chose, j'ai commencé à réfléchir avec mes propres connaissances, mais je me suis retrouvé face à beaucoup d'obstacles.

**Le problème :**
- Je comprenais le fonctionnement des bases de données
- Mais pas les méthodes pour les concevoir de manière évolutive ou dynamique
- J'avais la technique, mais pas assez de recul

**La solution :**
Après plusieurs recherches, j'ai découvert :
- **Les 12 Factors** → ligne de conduite pour applications cloud/microservices
- **Domain-Driven Design** (DDD)
- **Design Patterns** (Gang of Four)

→ Un ensemble de méthodes pour chaque situation.

---

## 🧩 Étape 1 : Identifier les Cross-Cutting Concerns

### Définition
Ce sont les besoins qui traversent **toutes** les applications, peu importe leur fonction métier.

→ Voir notes : [`/resources/architecture-patterns/cross-cutting-concerns.md`](../../../resources/architecture-patterns/cross-cutting-concerns.md)

### Application à mon projet
Le projet est une plateforme engineering. J'ai donc identifié les besoins communs.

**Questions posées :**
- Network ?
- Stockage ?
- Sécurité ?

### Scoping initial (draft)

#### 🌐 Réseau & Accès
1. Ingress (routage HTTP/HTTPS)
2. Load Balancer
3. Proxy

#### 📊 Observabilité
4. Logs/Monitoring

#### 💾 Stockage & Données
5. Volumes (persistance)

#### 🔐 Sécurité
6. Secrets management, Vault
7. Firewall, policies, RBAC

#### ⚡ Scalabilité & Résilience
8. Auto-scaling (HPA)
9. High Availability

#### 🚀 Déploiement & Lifecycle
10. CI/CD / GitOps

> Cette liste n'est peut-être pas parfaite, mais j'ai au moins un draft.

---

## 🧩 Étape 2 : Divide and Conquer

### Problème
J'ai 10 besoins complexes. Comment les organiser ?

### Solution appliquée
**Diviser pour régner** :
- Découper en catégories (réseau, sécu, observabilité...)
- Traiter chaque morceau indépendamment

→ Voir notes : [`/resources/architecture-patterns/divide-and-conquer.md`](../../../resources/architecture-patterns/divide-and-conquer.md)

---

## 🧩 Étape 3 : Dependency Analysis

### Question
Dans quel **ordre** dois-je implémenter ces besoins ?

### Méthode appliquée
Analyser les dépendances :
- Quoi dépend de quoi ?
- Exemple : RBAC avant ou après les composants applicatifs ?

→ Voir notes : [`/resources/architecture-patterns/dependency-analysis.md`](../../../resources/architecture-patterns/dependency-analysis.md)

### Décision : Security-First Design

**Principe retenu :** Les composants dépendent du RBAC.

**Exemple :**
- Prometheus doit lire les métriques de tous les Pods
- → On crée les rôles RBAC **avant** de déployer Prometheus

→ Voir notes : [`/resources/architecture-patterns/security-first-design.md`](../../../resources/architecture-patterns/security-first-design.md)

---

## 👥 Modélisation des Personas

### Objectif
Définir **qui** utilise la plateforme et **quelles** permissions.

### Personas identifiés

| Persona | Responsabilités |
|---------|-----------------|
| **Platform Admin** | Gestion infrastructure globale (moi aujourd'hui, mais aussi le rôle "admin" en général) |
| **Application Developer** | Déploiement d'applications |
| **Read-Only Operator** | Consultation métriques/logs |
| **Security Auditor** | Vérification conformité |

### Prochaine étape
Pour chaque persona → définir les **ClusterRoles** et **RoleBindings** Kubernetes.

---

## 📚 Références
- [The Twelve-Factor App](https://12factor.net/)
- "Domain-Driven Design" - Eric Evans
- "Design Patterns" - Gang of Four
