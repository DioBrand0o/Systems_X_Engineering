# API Contracts - OpenAPI Specifications

This folder contains the OpenAPI 3.0.0 specifications for all microservices in the blockchain platform.

## Files

### [`api-gateway.yaml`](./api-gateway.yaml)
Entry point for users. Handles authentication and transaction submission.

**Endpoints:**
- `POST /auth/login` - User authentication (returns JWT)
- `POST /transactions` - Submit a transaction (authenticated)
- `GET /transactions` - List user's transactions (authenticated)
- `GET /blocks` - List blockchain blocks (public)
- Health, readiness, and metrics endpoints

**Port:** `8080` (dev), configurable in production

---

### [`miner-service.yaml`](./miner-service.yaml)
Background mining service. No user-facing endpoints.

**Endpoints:**
- `GET /health` - Kubernetes liveness probe
- `GET /ready` - Kubernetes readiness probe (checks RabbitMQ)
- `GET /metrics` - Prometheus metrics

**Port:** `8081` (dev), configurable in production

**Note:** This service consumes `transaction.pending` queue and produces `block.mined` queue.

---

### [`node-service.yaml`](./node-service.yaml)
Validation and storage service. Exposes blockchain for public consultation.

**Endpoints:**
- `GET /blocks` - List blocks (pagination supported)
- `GET /blocks/{block_hash}` - Block details with transactions
- `GET /transactions/{tx_hash}` - Transaction details
- Health, readiness, and metrics endpoints

**Port:** `8082` (dev), configurable in production

---

## How to Use

### 1. View in Swagger UI

Visit [Swagger Editor](https://editor.swagger.io/) and paste any `.yaml` file to see the interactive documentation.

### 2. Generate Client Code

```bash
# Install openapi-generator
npm install @openapitools/openapi-generator-cli -g

# Generate Rust client for API Gateway
openapi-generator-cli generate \
  -i api/api-gateway.yaml \
  -g rust \
  -o generated/api-gateway-client
```

**Supported languages:** Rust, Python, Go, TypeScript, Java, and 40+ more.

### 3. Validate Contracts

```bash
# Install spectral (OpenAPI linter)
npm install -g @stoplight/spectral-cli

# Validate a contract
spectral lint api/api-gateway.yaml
```

---

## Contract Principles

### 1. One contract per service
Each microservice has a single OpenAPI file containing all its endpoints.

**Why?**
- Consistency: 1 service = 1 deployment = 1 contract
- Industry standard (Stripe, GitHub, Kubernetes)
- Easier to consume and generate code from

### 2. Observability endpoints on all services
Every service exposes:
- `/health` - Liveness probe
- `/ready` - Readiness probe
- `/metrics` - Prometheus metrics

**Why?**
- Production-ready from day one
- Kubernetes integration
- Monitoring with Prometheus/Grafana

### 3. Schema reusability with `$ref`
Common data structures are defined once in `components/schemas` and reused.

**Example:**
```yaml
components:
  schemas:
    Transaction:
      type: object
      properties:
        tx_hash:
          type: string

paths:
  /transactions:
    get:
      responses:
        '200':
          schema:
            $ref: '#/components/schemas/Transaction'
```

---

## API Flow

```
User
  ↓
API Gateway (POST /transactions)
  ↓
RabbitMQ (queue: transaction.pending)
  ↓
Miner Service (Proof of Work)
  ↓
RabbitMQ (queue: block.mined)
  ↓
Node Service (Validation + PostgreSQL)
```

---

## HTTP Status Codes

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Successful GET/POST (non-creation) |
| 201 | Created | Successful POST (resource created) |
| 400 | Bad Request | Invalid request data |
| 401 | Unauthorized | Missing/invalid JWT token |
| 404 | Not Found | Resource doesn't exist |
| 500 | Internal Server Error | Server-side error |
| 503 | Service Unavailable | Service not ready |

---

## Authentication

Endpoints marked with `security: - BearerAuth: []` require JWT authentication.

**How to authenticate:**
1. Call `POST /auth/login` with username/password
2. Receive JWT token in response
3. Include token in subsequent requests:

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Public endpoints (no auth):**
- `GET /blocks` (blockchain is transparent)
- All `/health`, `/ready`, `/metrics` endpoints

---

## References

- [OpenAPI 3.0 Specification](https://swagger.io/specification/)
- [Swagger Editor](https://editor.swagger.io/)
- [OpenAPI Generator](https://openapi-generator.tech/)
- [Spectral Linter](https://stoplight.io/open-source/spectral)
