## Terraform VPC Example

This example Terraform project creates the following infra:

- Imports KeyPair
- Creates VPC
- Creates Subnet
- Creates Security Group
  - Adds Ingress and Egress Rules
- Creates Internet Gateway
  - Attaches Internet Gateway to VPC
- Creates Route Table
  - Associates Route Table with Subnet
- Creates EC2 Instance in VPC
- Remotely executes script to install Nginx

### Deploying

- Ensure the following environemnt variables have been set:

      export AWS_SECRET_ACCESS_KEY=...
      export AWS_ACCESS_KEY_ID=...

- Initialise Terraform

      terraform init

- Deploy stack

      terraform deploy

### Destroying

- Assuming environment variables from deploy steps are set and that init and state files are present.

      terraform destroy