---

```markdown
# terraform-aws-python-app-deploy

**Deploy a sample Python application on AWS using Terraform**

---

## Overview

This project uses Terraform to provision AWS infrastructure and deploy a sample Python application on an EC2 instance. It covers common cloud components including VPC, subnets, internet gateway, security groups, and more.

---

## Features

- **Infrastructure-as-Code**: Define and manage AWS resources using Terraform HCL.
- **Networking**: Automate VPC, subnet, route table, and Internet Gateway setup.
- **Compute**: Launch EC2 instances with appropriate key pairs and security groups.
- **Extensible**: Easily customize variables and modules to suit different environments.
- **Sample Python App**: Deploy a simple demo app to validate functionality (located in the `python-app/` folder).

---

## Prerequisites

- [Terraform](https://www.terraform.io/) v1.0+ installed.
- AWS CLI configured with credentials and default region.
- SSH key pair setup (for EC2 access).

---

## Repository Structure

```

.
├── backend.tf          # Remote state configuration
├── providers.tf        # AWS provider configuration
├── variables.tf        # Input variables
├── terraform.tfvars    # Default variable values (not committed)
├── vpc.tf              # VPC resource definitions
├── subnet.tf           # Public/private subnets
├── rt.tf               # Route table definitions
├── igw\.tf              # Internet Gateway configuration
├── ec2\_sg.tf           # Security groups for EC2
├── ec2\_keypair.tf      # EC2 Key Pair setup
├── ec2\_instance.tf     # EC2 instance provisioning
├── output.tf           # Outputs (e.g., instance IP)
├── keys/               # SSH key pair directory
└── python-app/         # Sample Python application code

````

---

## Getting Started – Quick Setup

### 1. Clone the repository
```bash
git clone https://github.com/s11mani/terraform-aws-python-app-deploy.git
cd terraform-aws-python-app-deploy
````

### 2. Generate SSH keys

The EC2 instance requires an SSH key pair for access. Generate the keys inside the `keys/` directory:

```bash
cd keys
ssh-keygen -t rsa -b 4096 -f id_rsa
cd ..
```

This creates:

* `keys/id_rsa` → Private key (keep secure, do not commit to Git)
* `keys/id_rsa.pub` → Public key (uploaded to AWS via Terraform)

### 3. Review and edit `terraform.tfvars`

Update values like:

* `aws_region`
* `key_pair_name` (match your generated key name, e.g., `id_rsa`)
* `instance_type`
* `ami_id` (if not using the default)

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Preview the planned changes

```bash
terraform plan
```

### 6. Apply the deployment

```bash
terraform apply
```

Confirm with `yes` when prompted.

### 7. Access the application

After deployment, Terraform prints the EC2 instance’s public IP. Use it to access your Python app:

```
http://<instance-ip>:<port>
```

---

## Clean Up

Remove all created AWS resources to avoid unnecessary costs:

```bash
terraform destroy
```

---

## Configuration Variables

See `variables.tf` for full options. Common ones include:

| Variable              | Description             | Default/Example |
| --------------------- | ----------------------- | --------------- |
| `aws_region`          | AWS deployment region   | `us-east-1`     |
| `instance_type`       | EC2 instance type       | `t2.micro`      |
| `key_pair_name`       | Name of SSH key pair    | `id_rsa`        |
| `vpc_cidr`            | VPC CIDR block          | `10.0.0.0/16`   |
| `public_subnet_cidr`  | CIDR for public subnet  | `10.0.1.0/24`   |
| `private_subnet_cidr` | CIDR for private subnet | `10.0.2.0/24`   |

---

## Best Practices & Suggestions

* **State Management**: Use a remote backend (e.g., S3 + DynamoDB) for state locking in team settings.
* **Modularization**: Break resources into reusable modules (e.g., VPC, EC2, networking).
* **Security Enhancements**:

  * Apply least privilege IAM roles.
  * Restrict security group rules.
  * Consider using AWS Systems Manager to manage instances instead of SSH.
* **CI/CD Integration**: Automate Terraform runs via pipelines (e.g., GitHub Actions, Jenkins).
