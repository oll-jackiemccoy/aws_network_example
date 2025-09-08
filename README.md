# Endpoint and Route53 Resolver Test Environment

## Overview
This environment is designed to support training and testing of **Amazon VPC Endpoints** and **Route 53 Resolver** configurations.  
It simulates a real-world integration with Active Directory (AD) for name resolution and connectivity.

## Components

- **VPC Endpoints**  
  Provides private connectivity to AWS services without traversing the public internet.

- **VPC Peering to AD VPC**  
  Enables secure communication between the training VPC and the Active Directory VPC for DNS and authentication scenarios.

- **Outbound Resolver**  
  Configured to forward DNS queries from workloads inside the training VPC to the AD DNS servers.

- **Test EC2 Instances**  
  - **Linux instance** for command-line DNS and network testing.  
  - **Windows instance** for GUI-based and AD-aware testing.  
  - Both instances are provisioned with a **Systems Manager (SSM) role** attached, allowing remote management without requiring SSH/RDP.  
  - Instances are launched using my **existing key pair** and tagged with my name for identification.

## Objectives
- Demonstrate how to deploy and configure VPC Endpoints.  
- Show how Route 53 Resolver outbound rules forward DNS queries to AD.  
- Validate connectivity across peered VPCs.  
- Test connectivity and name resolution using both Linux and Windows EC2s.  
- Provide a sandbox for experimenting with resolver rules and troubleshooting.

## Prerequisites
- AWS account with permissions to create VPCs, Route 53 resolvers, VPC endpoints, and EC2 instances.  
- Access to an AD VPC or lab environment for peering.  
- IAM role or credentials with sufficient privileges.  
- A valid **EC2 key pair** in the target AWS Region.  

## Next Steps
1. Provision the base VPC and subnets.  
2. Establish VPC peering with the AD VPC.  
3. Deploy endpoints and resolvers.  
4. Launch the Linux and Windows EC2 instances with the SSM role.  
5. Configure DNS forwarding rules.  
6. Test name resolution and connectivity from both servers.  

