# Implementation Status

This document separates existing code from planned work.

## Implemented in the current baseline

- AWS provider configuration, version constraints, and default resource tags.
- A reusable networking module.
- A VPC with DNS support and DNS hostnames enabled.
- Two public subnets and two private subnets across available Availability Zones.
- An Internet Gateway and public route table.
- Public subnet route-table associations.
- Root outputs for the VPC and subnet IDs.
- GitHub Actions checks for Terraform formatting and validation.

## Not implemented yet

- Explicit private route-table associations and private outbound routing.
- NAT Gateway.
- Application Load Balancer and application compute.
- Application IAM roles and policies.
- CloudWatch alarms and dashboards.
- Remote Terraform state and locking configuration.
- A reviewed plan/apply workflow.

## Safety notes

- GitHub Actions currently runs formatting, initialization, and validation only. It does not authenticate to AWS or create resources.
- Private subnets currently have no explicit route-table association or NAT route. Treat them as isolated until private routing is deliberately designed.
- Review Terraform plans before applying changes.
- NAT Gateways, load balancers, EC2 instances, and other cloud resources can incur charges.
- Never commit AWS keys, private keys, real secret values, Terraform state, or a real terraform.tfvars file.
