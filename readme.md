# AWS Infrastructure with Terraform

Terraform implementation of the AWS infrastructure from the [KodeKloud AWS Basics course](https://learn.kodekloud.com/user/courses/crash-course-aws-basics). The course is intended to be completed through the AWS Management Console — but if you're the type who learns by going deeper, this repo provisions the exact same infrastructure using Terraform with modules, multi-environment support, and variables management.

## 🏗️ What's in here

This repo provisions the following AWS resources using Terraform:

- 🌐 **VPC** with subnets and Internet Gateway
- 🖥️ **EC2** instances running Docker containers
- ⚖️ **Application Load Balancer (ALB)**
- 🗄️ **RDS** database
- 🔐 **IAM** roles and policies
- 🔑 **KMS** encryption
- 🔒 **Secrets Manager**

Terraform best practices followed: reusable modules, multi-environment support, and variables management.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured (`aws configure`)

## How to run

> **Note:** Once the KodeKloud live lab session is started, run the following commands in the lab terminal.

```bash
# Clone the repo
git clone https://github.com/galactusclb/terraform-aws-kodecloud.git
cd terraform-aws-kodecloud

# Give execute permission and run the install script
chmod +x install.sh
./install.sh

# Initialize Terraform
terraform init

# Apply for dev environment
terraform apply -var-file=environments/dev/terraform.tfvars
```

## Environments

The `environments/` directory contains variable files for different environments. To deploy to a different environment, swap the `terraform.tfvars` path accordingly:

```bash
terraform apply -var-file=environments/prod/terraform.tfvars
```