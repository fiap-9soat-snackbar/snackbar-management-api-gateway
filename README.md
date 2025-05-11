# snackbar-management-api-gateway

# API Gateway with JWT Lambda Authorizer

This Terraform configuration provisions an **AWS API Gateway (HTTP API)** integrated with a **Lambda JWT Authorizer** to protect specific routes. The API Gateway routes requests to an Application Load Balancer (ALB) and includes public/unprotected endpoints and authenticated routes requiring JWT validation.

---

## 🚀 Features

- **HTTP API Gateway**: Lightweight, fast, and cost-effective API Gateway for HTTP-based integrations.
- **Lambda JWT Authorizer**: Custom authorizer to validate JWT tokens for protected routes.
- **Public & Protected Routes**:
  - Public routes (`/health`, `/signup`, `/login`) with no authentication.
  - Protected routes (`/users/*`, `/products/*`) requiring a valid JWT token.
- **ALB Integration**: Routes requests to backend services via an ALB.
- **CloudWatch Logging**: Access logs for API Gateway requests.
- **Terraform Provisioning**: Infrastructure-as-Code (IaC) for repeatable deployments.

---

## 📐 Architecture

The architecture follows this flow for incoming requests:

1. **Client** → **API Gateway**  
   - Requests are sent to the API Gateway endpoint.
2. **API Gateway** → **Lambda Authorizer** (for protected routes)  
   - For protected routes, the API Gateway invokes the Lambda Authorizer to validate the JWT token in the `Authorization` header.
3. **Lambda Authorizer**  
   - Validates the JWT token signature and expiration using a pre-shared secret key.
   - Returns `isAuthorized: true/false` to API Gateway.
4. **API Gateway** → **ALB**  
   - If authorized, the request is forwarded to the ALB (e.g., `http://alb-dns-name/api/product`).

---

## 🛠️ Terraform Resources

| Resource Type                          | Purpose                                                                 |
|----------------------------------------|-------------------------------------------------------------------------|
| `aws_apigatewayv2_api`                 | Creates the HTTP API Gateway.                                          |
| `aws_apigatewayv2_authorizer`          | Configures the Lambda Authorizer for JWT validation.                   |
| `aws_apigatewayv2_integration`         | Defines integration with the ALB for routing requests.                 |
| `aws_apigatewayv2_route`               | Maps routes to integrations with appropriate authorization.            |
| `aws_cloudwatch_log_group`             | Stores access logs for API Gateway.                                    |
| `aws_apigatewayv2_stage`               | Deploys the API Gateway stage (`$default`) with logging enabled.       |
| `aws_lambda_permission`                | Grants API Gateway permission to invoke the Lambda Authorizer.         |

---

## 📚 API Endpoints

### Authentication Endpoints

| Method | Endpoint | Description | Authentication |
|--------|----------|-------------|----------------|
| POST   | /signup  | Register a new user | None |
| POST   | /login   | Authenticate a user and get a JWT token | None |

### User Management Endpoints

| Method | Endpoint | Description | Authentication |
|--------|----------|-------------|----------------|
| GET    | /users   | Get all users | JWT |
| GET    | /users/cpf/{cpf} | Get user by CPF | JWT |
| PUT    | /users/{id} | Update user | JWT |
| DELETE | /users/{id} | Delete user | JWT |

### Product Endpoints

| Method | Endpoint | Description | Authentication |
|--------|----------|-------------|----------------|
| POST   | /products | Create a new product | JWT |
| GET    | /products | Get all products | JWT |
| GET    | /products/id/{id} | Get product by ID | JWT |
| GET    | /products/category/{category} | Get products by category | JWT |
| GET    | /products/name/{name} | Get product by name | JWT |
| PUT    | /products/id/{id} | Update product | JWT |
| DELETE | /products/id/{id} | Delete product | JWT |

### Health Check

| Method | Endpoint | Description | Authentication |
|--------|----------|-------------|----------------|
| GET    | /health  | Check the health of the API | None |

---

## 🚀 Deployment

### Prerequisites
1. **AWS CLI Configured** with valid credentials.  
2. **Terraform v1.0+** installed.  
3. **Variables Prepared**:
   - `alb_dns_name` (ALB DNS name from your infrastructure).
   - `bucket` (S3 bucket for Terraform state).

---

## 🛠️ How to Run Terraform

### Initialize Terraform
```bash
terraform init -backend-config="bucket=YOUR_S3_BUCKET_NAME"
```

### Plan Infrastructure
Preview changes before applying them:
```bash
terraform plan -var="alb_dns_name=YOUR_ALB_DNS_NAME" -var="bucket=YOUR_S3_BUCKET_NAME"
```

### Apply Configuration
Create or update AWS resources:
```bash
terraform apply -var="alb_dns_name=YOUR_ALB_DNS_NAME" -var="bucket=YOUR_S3_BUCKET_NAME"
```

### Destroy Resources
Remove all resources when no longer needed:
```bash
terraform destroy -var="alb_dns_name=YOUR_ALB_DNS_NAME" -var="bucket=YOUR_S3_BUCKET_NAME"
```

---

## 🔄 Related Repositories

- [Snackbar Management](https://github.com/fiap-9soat-snackbar/snackbar-management) - Main application repository
- [Snackbar Management Queue](https://github.com/fiap-9soat-snackbar/snackbar-management-queue) - Queue processing service
