# ADR-003 : Choix du message broker

## Contexte
[Pourquoi tu as besoin de communication asynchrone]
on a besoins d'avoir de la resiliance ,  du decoupage , un odre de traiement specifique et Priorisation pour repondre au demmande du service

## Options considérées
- Kafka
- RabbitMQ

### Option 1 : RabbitMQ
**Avantages :**
RabbitMQ :

Message broker classique (AMQP)
30-40K messages/sec (suffisant pour ton projet)
Pas de limite de taille de payload
Plus simple pour microservices traditionnels
...
**Inconvénients :**
...

pas de log distribué
moins de performan que kafka
pas de replay 

### Option 2 : Kafka
**Avantages :**

Event streaming
2 millions/sec 
Replay possible 
Plus complexe à opérer
...
**Inconvénients :**
...
Plus complexe à opérer



## Décision

RabbitMQ

Raisons :
1. Performance suffisante (30-40K msg/sec vs besoin de ~100 tx/sec)
2. Simplicité opérationnelle (moins de ressources homelab)
3. Adapté microservices point-à-point

## Conséquences
**Positives :**

- plus simple 
- performence suffisante
...
**Trade-offs acceptés :**
...
- moins performent 
- pas de replay 
- pas de log distrubé 

