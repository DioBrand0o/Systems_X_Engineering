# Journal de Conception - Méthodologie

## Contexte
J'en suis à la conception du projet. Il est important pour moi de comprendre comment réfléchir et d'acquérir une méthodologie, pour utiliser les outils avec logique, efficacité et efficience.

---

## À la Recherche de la Méthodologie

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

## Etape 1 : Identifier les Cross-Cutting Concerns

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

#### Réseau & Accès
1. Ingress (routage HTTP/HTTPS)
2. Load Balancer
3. Proxy

#### Observabilité
4. Logs/Monitoring

#### Stockage & Données
5. Volumes (persistance)

#### Sécurité
6. Secrets management, Vault
7. Firewall, policies, RBAC

#### Scalabilité & Résilience
8. Auto-scaling (HPA)
9. High Availability

#### Déploiement & Lifecycle
10. CI/CD / GitOps

> Cette liste n'est peut-être pas parfaite, mais j'ai au moins un draft.

---

## Étape 2 : Divide and Conquer

### Problème
J'ai 10 besoins complexes. Comment les organiser ?

### Solution appliquée
**Diviser pour régner** :
- Découper en catégories (réseau, sécu, observabilité...)
- Traiter chaque morceau indépendamment

→ Voir notes : [`/resources/architecture-patterns/divide-and-conquer.md`](../../../resources/architecture-patterns/divide-and-conquer.md)

---

## Étape 3 : Dependency Analysis

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

## Modélisation des Personas

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

Je cherche mais je commence à partir dans tous les sens. C'est là que je découvre les ADR !
ADR, c'est la traçabilité des décisions dans le temps.
Dedans il y a le pourquoi, la comparaison des outils, les + et les -, etc.

Exemple : Il peut je prend un parapluie aujourd'hui, demain il fait beau pas de parapluie. Donc si je regarde pourquoi j'avais un parapluie aujourd'hui dans l'ADR je vais voir qu'il pleuvait
et si je regarde pourquoi j'ai pas de parapluie demain, je vois dans l'ADR qu'il fait beau.

ADR-001 : "Je prends un parapluie"

Contexte : Il pleut aujourd'hui
Décision : Parapluie
Conséquences : Je reste au sec

ADR-002 : "Je ne prends pas de parapluie" (supersedes ADR-001)

Contexte : Il fait beau maintenant
Décision : Pas de parapluie
Conséquences : Je gagne du poids dans le sac

Permet de garder l'historique complet du raisonnement.

Liste des ADR identifiés :

ADR-001 : Choix du langage backend (Go)
ADR-002 : Choix de la base de données (PostgreSQL)
ADR-003 : Choix du message broker (RabbitMQ)
ADR-004 : Choix du CNI (Calico/Cilium/autre)
ADR-005 : Choix de l'Ingress Controller (Nginx/Traefik)
ADR-006 : Choix de la solution de secrets (Vault/Sealed Secrets)
ADR-007 : Choix de la stack de logs (Loki/ELK)
ADR-008 : Choix de la stack de monitoring (Prometheus)
ADR-009 : Choix de l'outil GitOps (ArgoCD/Flux)

Après je peux les changer plus tard selon comment ça évolue.

ADR-001 : Pourquoi Go ?

Je le vois souvent et des offres commencent à apparaître avec du Go
Compilé pas interprété
Rapide
Léger pas de runtime mais du binaire

Les avantages : https://go.dev/solutions/cloud
Puis le pivot :
Bon après avoir fait l'ADR je me rends compte que Rust est plus compliqué mais plus sécurisé donc je bascule sur Rust.
ADR aide vraiment à se poser les bonnes questions.


Donc pour pas sombrer dans la théorie je fais 3 ADR : DB et message broker. Plus tard je fais K8s.

2ème ADR : DB
On part sur le même principe mais comment bien choisir sa BDD surtout si finalement on ne connaît pas vraiment l'application et ses aboutissants.
La blockchain : donc la 1ère étape est de comprendre le workflow : hash, block, blockchain, Distributed.
Ressource super utile : https://andersbrownworth.com/blockchain/

Je résume :

Hash SHA-256 = empreinte unique du contenu
'Chaînage' = chaque bloc contient le hash du bloc précédent
Immuabilité = modifier un bloc casse toute la chaîne après lui
Traçabilité + anonymat = on voit les transactions, pas forcément l'identité

Problème central d'une blockchain distribuée : le consensus.
Consensus = le réseau accepte le bloc miné valide le plus rapide.
Si les deux créent en même temps ?
Version avec mining (Proof of Work) :

Tu veux créer un bloc ? Tu dois résoudre un puzzle mathématique difficile.
Ce puzzle prend du temps et de l'énergie (électricité, CPU).
Résultat : Créer un bloc coûte cher → spam difficile

Maintenant que je comprends mieux le fonctionnement, ADR DB peut être fait.
Et ensuite vient du transporteur de message : ADR message broker.

J'ai rédigé 3 ADR complets :

ADR-001 : Rust (décision architecturale majeure)
ADR-002 : PostgreSQL (stockage)
ADR-003 : RabbitMQ (communication)

Ce que je comprend maintenant :

Méthodologie ADR (contexte → options → décision → conséquences)
Comparaison d'alternatives techniques
Justification de choix avec trade-offs
Documentation d'architecture

---

## Références
- [The Twelve-Factor App](https://12factor.net/)
- "Domain-Driven Design" - Eric Evans
- "Design Patterns" - Gang of Four
- https://adr.github.io/adr-templates/
