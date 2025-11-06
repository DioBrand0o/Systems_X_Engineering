# Systems Engineering Portfolio

> "Understanding how things work under the hood"

Personal repository documenting my journey into advanced systems programming and cloud-native infrastructure.

## Skills Demonstrated

- **Cloud-Native Infrastructure** – Kubernetes (Talos), Terraform, GitOps  
- **Systems Programming** – Rust, KVM, Linux kernel internals  
- **Distributed Systems** – Microservices, message queues, consensus  
- **Platform Engineering** – Observability, CI/CD, security-first design  
- **Architecture** – ADRs, C4 model, design patterns

---

## Projects

### [`/blockchain-microservices`](./blockchain-microservices)
**How do you architect a production-grade distributed system?**

Designing and deploying a blockchain application using microservices patterns and Kubernetes orchestration.

**Tech:** Rust · Kubernetes · PostgreSQL · RabbitMQ · Terraform  
**Challenge:** Building resilient, scalable, and observable distributed services.

**Key deliverables:**
- Architecture Decision Records (ADRs)
- Production-ready Kubernetes manifests
- CI/CD pipeline with security scanning
- Observability stack (Prometheus/Grafana/Loki)

---

### [`/do-serverless`](./do-serverless)
**What if you could run untrusted code in isolated micro-VMs?**

Building a lightweight serverless runtime that combines virtualization and containerization from scratch.

**Tech:** Rust · KVM · rust-vmm · OCI runtime spec  
**Challenge:** Creating a VMM (Virtual Machine Monitor) and container runtime, then merging both worlds.

**Components:**
- **lumper** – Custom VMM using rust-vmm
- **run0** – Minimal OCI-compliant container runtime
- **quark** – CLI orchestrator (planned)

---

### [`/resources`](./resources)
**Learning is not just coding.**

Curated notes, architecture patterns, and references from industry books and papers that shaped these projects.

Think of it as my personal knowledge base.

**Topics covered:**
- Architecture patterns (DDD, 12-Factor, Clean Architecture)
- Distributed systems fundamentals
- SRE practices (SLO/SLI, observability)
- Security-first design

---

## Why This Matters

Most engineers **use** Docker and Kubernetes.  
I'm learning how they **work**.

This repository reflects a **first-principles approach** to understanding modern infrastructure, from syscalls to orchestration layers.

---

## Progress

| Project | Status | Next Milestone |
|---------|--------|----------------|
| blockchain-microservices | In progress (Architecture & Design) | Infrastructure setup (Proxmox + Talos) |
| do-serverless | Early stage (Environment Setup) | VMM implementation (KVM integration) |

Check individual folders for detailed [architecture decisions](./blockchain-microservices/docs/architecture/) and [development logs](./blockchain-microservices/docs/journal/).

---

## Let's Connect

[LinkedIn](https://www.linkedin.com/in/zack-bou) · [GitHub](https://github.com/DioBrand0o)
