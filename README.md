# AWS Production Infrastructure with Terraform

A hands-on Infrastructure as Code project that builds an AWS network foundation and evolves toward a production-oriented application platform.

> **Current status:** Networking baseline and Terraform CI validation are implemented. The complete production architecture is still in progress; see [implementation status](docs/implementation-status.md).

## Goals
- Provision infrastructure consistently using Terraform.
- Organize cloud resources into reusable modules.
- Use clear naming, default tags, variables, and outputs.
- Validate Terraform automatically in GitHub Actions.
- Document security, operational trade-offs, and cleanup before deploying billable resources.

## Current architecture
The current baseline creates a VPC, two public subnets, two private subnets, an Internet Gateway, and a public route table with associations.
See [the current architecture](docs/architecture.md) for the diagram and routing limitations.

## Technology stack
- AWS
- Terraform
- GitHub Actions
- Amazon VPC and subnets
- Internet Gateway and route tables

## Repository structure

```text
.
├── .github/workflows/terraform-validate.yml
├── docs/
│   ├── architecture.md
│   └── implementation-status.md
├── modules/networking/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .gitignore
├── main.tf
├── outputs.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

## Prerequisites
- Terraform CLI compatible with the version constraint in versions.tf.
- Git.
- AWS CLI and configured credentials only if you intend to create real AWS resources.
- An AWS account and an approved budget before applying billable infrastructure.

## Validate locally without creating AWS resources
Run these commands from the repository root:

```bash
# Check Terraform formatting without changing files.
terraform fmt -check -recursive

# Initialize provider dependencies without configuring a remote state backend.
terraform init -backend=false

# Validate Terraform syntax and configuration consistency.
terraform validate
```

These checks do not create or modify AWS resources. The GitHub Actions workflow runs the same checks for pushes to main and pull requests targeting main.

## Configure for an AWS deployment
1. Review the Terraform code and intended AWS region.
2. Copy terraform.tfvars.example to terraform.tfvars and adjust non-secret values.
3. Configure AWS credentials using your normal local AWS credential mechanism. Do not place access keys in Terraform files.
4. Run terraform plan and carefully inspect the proposed changes.
5. Only run terraform apply after reviewing the plan and expected AWS charges.
6. When the environment is no longer needed, review resources and run terraform destroy only if you are certain they are safe to remove.

Do not commit terraform.tfvars, AWS credentials, private keys, or Terraform state files.

## Roadmap
- [x] Terraform provider and version constraints
- [x] VPC and public/private subnet baseline
- [x] Internet Gateway and public route table
- [x] Root networking outputs
- [x] GitHub Actions format and validation checks
- [ ] Explicit private route tables and associations
- [ ] Security groups and least-privilege IAM
- [ ] Application Load Balancer and compute tier
- [ ] CloudWatch alarms and dashboards
- [ ] Remote state and locking strategy
- [ ] Reviewed plan/apply workflow
- [ ] End-to-end deployment test and evidence

## Cost and security
This is a learning project, not a claim that the entire design is production-ready. Some future components—such as NAT Gateways, load balancers, EC2 instances, and monitoring services—can incur charges. Review current AWS pricing before deployment and clean up resources when finished.