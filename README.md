# otel-ecommerce-infra

[![CI-CD pipeline](https://github.com/HasanAshab/otel-ecommerce-infra/actions/workflows/cicd.yaml/badge.svg)](https://github.com/HasanAshab/otel-ecommerce-infra/actions/workflows/cicd.yaml)
[![Drift Detection](https://github.com/HasanAshab/otel-ecommerce-infra/actions/workflows/drift.yaml/badge.svg)](https://github.com/HasanAshab/otel-ecommerce-infra/actions/workflows/drift.yaml)

This repository contains the infrastructure (IaC) for [the Spring React DevOps App Service](https://github.com/HasanAshab/otel-ecommerce-devops) project.


## ⚙️ CI/CD Pipeline

![Push Pipeline](static/images/cicd.png)
---


## 🚀 How to Apply

Follow these steps to deploy the infrastructure using Terraform:

### 1. Copy Environment Configuration

```bash
cp .env.sample .env
```

Edit `.env` and override necessary variables according to your environment (e.g., subscription ID, tenant ID, resource group names).

### 2. Load Environment Variables

```bash
source ./bin/load_env.sh
```

This script will export all environment variables defined in `.env` for the current shell session.

### 3. Select Terraform Workspace

Choose the workspace you want to deploy (e.g., `dev` or `prod`):

```bash
terraform workspace select dev
```

If the workspace doesn't exist yet, create it:

```bash
terraform workspace new dev
```

### 4. Apply Terraform Configuration

Run Terraform apply with the corresponding tfvars file:

```bash
terraform apply -var-file=dev.tfvars
```

For production:

```bash
terraform apply -var-file=prod.tfvars
```
