# 🚀 terraform-aws-python-app-deploy

**Deploy a Sample Python Application on AWS using Terraform**

---

## 📖 Overview

This project uses **Terraform** to provision AWS infrastructure and deploy a sample **Python application** on an **EC2 instance**.  
It covers essential cloud components including **VPC, subnets, Internet Gateway, security groups**, and more.

---

## ✨ Features

- 🛠 **Infrastructure-as-Code**: Manage AWS resources using Terraform HCL.
- 🌐 **Networking**: Automate VPC, subnet, route table, and Internet Gateway setup.
- 💻 **Compute**: Launch EC2 instances with SSH key pairs & security groups.
- 🔄 **Extensible**: Easily customize variables and modules.
- 🐍 **Sample Python App**: A simple demo app for validation (in `python-app/` folder).

---

## 📦 Prerequisites

- [Terraform](https://www.terraform.io/) **v1.0+**
- AWS CLI configured with credentials & default region
- SSH key pair setup (for EC2 access)

---

## 📂 Repository Structure

```
.
├── backend.tf          # Remote state configuration
├── providers.tf        # AWS provider configuration
├── variables.tf        # Input variables
├── terraform.tfvars    # Default values (not committed)
├── vpc.tf              # VPC resources
├── subnet.tf           # Public/private subnets
├── rt.tf               # Route tables
├── igw.tf              # Internet Gateway
├── ec2_sg.tf           # Security groups
├── ec2_keypair.tf      # EC2 key pair setup
├── ec2_instance.tf     # EC2 provisioning
├── output.tf           # Outputs (e.g., public IP)
├── keys/               # SSH key pair directory
└── python-app/         # Python application code
```

---

## ⚡ Quick Start

### 1️⃣ Clone the repository
```bash
git clone https://github.com/s11mani/terraform-aws-python-app-deploy.git
cd terraform-aws-python-app-deploy
```

### 2️⃣ Generate SSH Keys
```bash
cd keys
ssh-keygen -t rsa -b 4096 -f id_rsa
cd ..
```
This creates:
- 🔑 `keys/id_rsa` → Private key (keep secure)
- 📄 `keys/id_rsa.pub` → Public key (uploaded to AWS)

### 3️⃣ Update `terraform.tfvars`
Edit values like:
- `aws_region`
- `key_pair_name`
- `instance_type`
- `ami_id`

### 4️⃣ Initialize Terraform
```bash
terraform init
```

### 5️⃣ Plan changes
```bash
terraform plan
```

### 6️⃣ Deploy 🚀
```bash
terraform apply
```
Confirm with `yes`.

### 7️⃣ Access App
```
http://<instance-ip>:<port>
```

---

## 🧹 Clean Up
```bash
terraform destroy
```

---

## ⚙ Configuration Variables

| Variable              | Description             | Default / Example |
| --------------------- | ----------------------- | ----------------- |
| `aws_region`          | AWS deployment region   | `us-east-1`       |
| `instance_type`       | EC2 instance type       | `t2.micro`        |
| `key_pair_name`       | SSH key pair name       | `id_rsa`          |
| `vpc_cidr`            | VPC CIDR block          | `10.0.0.0/16`     |
| `public_subnet_cidr`  | Public subnet CIDR      | `10.0.1.0/24`     |
| `private_subnet_cidr` | Private subnet CIDR     | `10.0.2.0/24`     |

---

## 🏆 Best Practices

- 📌 **State Management**: Use S3 + DynamoDB for state locking.
- 📦 **Modularization**: Split resources into reusable modules.
- 🔐 **Security**:
  - Apply least privilege IAM roles
  - Restrict SG rules
  - Use AWS Systems Manager instead of SSH
- 🤖 **CI/CD Integration**: Automate with GitHub Actions, Jenkins, etc.

---
