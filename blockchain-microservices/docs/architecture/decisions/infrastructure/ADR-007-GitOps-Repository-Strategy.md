## Décision

**Multi-repo (Option 1)**

**Raisons:**
1. **Séparation des préoccupations** → GitOps = infrastructure, pas dev
2. **GitOps best practice** → repo deploy séparé du code source
3. **Pipelines distincts** → build (code repo) vs sync (GitOps repo)
4. **Scalabilité** → prêt pour collaboration future
5. **Clarté** → ArgoCD ne surveille QUE l'infrastructure

## Conséquences

### Positives
- Séparation claire dev vs ops
- GitOps pur (ArgoCD surveille deploy uniquement)
- Permissions granulaires possibles
- Conforme aux standards industrie

### Trade-offs acceptés
- 2 repos à maintenir
- Workflow légèrement plus complexe
- Synchronisation code ↔ manifests à gérer

## Implémentation

**Repository 1: blockchain-microservices (Code)**
```
blockchain-microservices/
├── src/                  # Code Rust
├── Dockerfile
├── .gitlab-ci.yml       # Build + Push images
└── docs/
```

**Repository 2: argocd (GitOps)**
```
argocd/
├── apps/blockchain/
│   ├── postgres/manifests/
│   ├── rabbitmq/manifests/
│   └── api-gateway/manifests/
└── projects/blockchain.yaml
```

**Workflow:**
1. Commit code Rust → `blockchain-microservices`
2. CI build image → push registry
3. Update manifest image tag → `argocd` repo
4. ArgoCD détecte → deploy