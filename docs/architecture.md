# Current Network Architecture

The networking module currently creates this baseline:

```text
                         AWS Region
                             |
                             v
                            VPC
                     CIDR 10.20.0.0/16
                             |
             +---------------+---------------+
             |                               |
             v                               v
       Public Subnets                  Private Subnets
       - Public subnet 1               - Private subnet 1
       - Public subnet 2               - Private subnet 2
             |                               |
             v                               v
       Public Route Table              No explicit route table
             |                         associations yet
             v
       Internet Gateway
```

## Important details

- Public subnet CIDRs are derived from the VPC CIDR using Terraform's cidrsubnet function.
- Public subnets use a default route to the Internet Gateway.
- Public subnets map public IP addresses on launch.
- Private subnets do not map public IP addresses on launch.
- Private subnet egress routing has not been configured. A NAT Gateway is intentionally omitted from this baseline to avoid introducing a potentially billable resource before it is needed.

## Next architecture milestones

1. Add explicit private route-table associations.
2. Decide whether private workloads need outbound internet access; add NAT only if required and budgeted.
3. Add security groups with least-privilege rules.
4. Add an application tier and an internet-facing Application Load Balancer.
5. Add monitoring, alarms, and a reviewed deployment workflow.
