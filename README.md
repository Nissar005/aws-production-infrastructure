# AWS Production Infrastructure with Terraform

Production-style AWS infrastructure built with **Terraform** using Infrastructure as Code principles.

## Project Goal

Build a reusable AWS environment that demonstrates how cloud infrastructure can be provisioned, configured, reviewed, and safely destroyed through code.

## Planned Architecture

```text
Internet
   |
   v
Application Load Balancer
   |
   +-------------------+
   |                   |
Public Subnet       Public Subnet
   |                   |
   +---------+---------+
             |
        Private Subnets
             |
        Application Tier
             |
          Database
```

## Technologies

- AWS
- Terraform
- VPC
- IAM
- EC2
- Application Load Balancer
- Security Groups
- CloudWatch
- Infrastructure as Code

## Repository Structure

```text
.
├── environments/
│   └── dev/
├── modules/
│   ├── networking/
│   ├── compute/
│   └── security/
├── .gitignore
└── README.md
```

## Implementation Roadmap

- [ ] Terraform provider and version constraints
- [ ] VPC and subnet design
- [ ] Route tables and gateways
- [ ] Security groups
- [ ] IAM roles and least-privilege policies
- [ ] EC2 application tier
- [ ] Application Load Balancer
- [ ] CloudWatch monitoring
- [ ] Variables, outputs, and reusable modules
- [ ] Environment separation
- [ ] Terraform validation and formatting in CI
- [ ] Terraform plan workflow
- [ ] Documentation and architecture diagram

> This repository is being built incrementally as a practical DevOps learning project. Infrastructure will be documented and tested before any production deployment claims are made.
