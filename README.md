# DevOps Learning Path

> "Understanding how things work under the hood"

Personal repository documenting my journey into advanced systems programming and cloud-native infrastructure.

## Projects

### [`/do-serverless`](./do-serverless)
**What if you could run untrusted code in isolated micro-VMs?**

Building a lightweight serverless runtime that combines virtualization and containerization from scratch.

**Tech:** Rust · KVM · Linux kernel · OCI runtime spec

**Challenge:** Creating a VMM (Virtual Machine Monitor) and container runtime, then merging both worlds.

---

### [`/blockchain-microservices`](./blockchain-microservices)
**How do you architect a production-grade distributed system?**

Designing and deploying a blockchain application using microservices patterns and Kubernetes orchestration.

**Tech:** Go · Kubernetes · PostgreSQL · RabbitMQ · Terraform

**Challenge:** Building resilient, scalable, and observable distributed services.

---

### [`/resources`](./resources)
**Learning is not just coding.**

Curated notes, architecture patterns, and references from industry books and papers that shaped these projects.

Think of it as my personal knowledge base.

---

## Why This Matters

Most engineers *use* Docker and Kubernetes.  
I'm learning how they *work*.

---

## Progress

Both projects are **in active development**.  
Check individual folders for architecture decisions and implementation notes.

## Let's Connect

[www.linkedin.com/in/zack-bou]

```

---

# 📁 STRUCTURE 
```
DevOps/
├── README.md                          
│
├── do-serverless/
│   └── ...
│
├── blockchain-microservices/
│   └── ...
│
└── resources/                       
    ├── README.md                      
    ├── architecture-patterns/         
    │   ├── strategy-pattern.md
    │   ├── event-sourcing.md
    │   └── saga-pattern.md
    ├── books/                         
    │   ├── clean-architecture.md
    │   ├── building-microservices.md
    │   └── site-reliability-engineering.md
    ├── papers/                        
    │   ├── raft-consensus.md
    │   
    └── references/                    
        └── curated-links.md
---
```
