# ADR-001 : Choix du langage backend

## Contexte
Projet blockchain nécessitant :
- Sécurité (transactions/données sensibles)
- Performance (microservices distribués)
- Compatibilité écosystème cloud-native (Kubernetes)

J'ai également un projet parallèle (do-serverless) en Rust.

## Options considérées

### Option 1 : Go
**Avantages :**
- Mature pour la CNCF et les 12 Factors
- Courbe d'apprentissage rapide (2-4 semaines)

**Inconvénients :**
- Sécurité mémoire moins stricte que Rust
- Besoin d'apprendre 2 langages (Go ici, Rust pour do-serverless)

### Option 2 : Rust
**Avantages :**
- Sécurité mémoire garantie (ownership model)
- En lien avec mon projet do-serverless
- Demandé sur le marché 

**Inconvénients :**
- Courbe d'apprentissage plus longue 
- Écosystème cloud moins mature que Go

## Décision
**Rust**

Raisons :
1. Cohérence : un seul langage pour 2 projets
2. Sécurité critique pour blockchain
3. Investissement long terme

## Conséquences
**Positives :**
- Expertise Rust transférable entre projets
- Sécurité mémoire par design

**trade-offs acceptés :**
- Temps de développement initial plus long
- Moins de SDKs cloud providers (devra utiliser HTTP clients génériques)


## Références
[1] Rust for Cloud Native - https://www.rust-lang.org/what/networking
[2] CNCF Landscape - https://landscape.cncf.io/
