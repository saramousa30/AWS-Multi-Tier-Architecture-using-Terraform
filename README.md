# AWS Multi-Tier Architecture using Terraform

> **Note:** This project uses Terraform to deploy a secure, scalable, and highly available multi-tier infrastructure on AWS.  
>  
> 🔗 *If you're here to test or deploy quickly, jump to the [Build & Deploy](#3-build--deploy) section.*

---

## 🖼 Architecture Diagram

![Architecture Diagram](AWS_Multi-Tier_Architecture.drawio.svg)

---

## 🧩 Solution Overview

This solution provisions a **multi-tier web architecture** using Terraform on AWS, focusing on **modularity**, **security**, and **scalability**. The infrastructure follows industry-standard best practices by isolating layers (bastion, web tier, and database) using VPC networking, proper subnet segmentation, and tightly scoped security groups.

It is designed to serve real-world cloud workloads like web applications, internal services, and backend APIs that require:

- **Secure SSH access to private resources**
- **Dynamic web server scaling**
- **Database segregation**
- **Automated monitoring and alerting**

### ✨ Core Capabilities

- **Modular Infrastructure-as-Code (IaC):**  
  Each AWS resource layer is split into reusable Terraform modules (e.g., VPC, EC2, ALB, RDS, ASG, CloudWatch, SNS). This structure makes the codebase easier to maintain, extend, and customize across projects.

- **High Availability and Fault Tolerance:**  
  The architecture spans **multiple Availability Zones (AZs)** in the AWS `us-east-1` region to ensure redundancy. Public/private subnets, RDS, and Auto Scaling Group (ASG) deployments are all distributed across AZs to minimize single points of failure.

- **Layered Access Control:**  
  Each component (bastion, web server, database) is governed by its own **security group**. These allow only the necessary traffic between layers (e.g., ALB → Web SG, Web SG → DB SG) while blocking everything else by default.

- **Dynamic Web Tier with Auto Scaling:**  
  Web application servers are launched using an **ASG** with a **Launch Template**. Instances are bootstrapped via a templated UserData script, allowing for dynamic injection of environment variables like RDS endpoints and database credentials.

- **Centralized Load Balancing:**  
  An **Application Load Balancer (ALB)** receives all incoming HTTP traffic and distributes it to the private EC2 web servers, with real-time health checks to route traffic only to healthy targets.

- **Managed Database (RDS):**  
  The backend tier uses **Amazon RDS** for MySQL. It is launched in private subnets for improved security, with no direct public access. It is integrated with the web tier through security group rules and DNS-based discovery.

- **Monitoring & Notifications:**  
  A **CloudWatch Alarm** monitors EC2 CPU usage. When the average usage exceeds a specified threshold, an **SNS Topic** sends email notifications to administrators. This enables proactive infrastructure monitoring without requiring manual checks.

- **Remote Terraform State Management (Optional):**  
  A remote backend can be configured using an **S3 bucket** (with optional DynamoDB locking) to safely store `terraform.tfstate` files. This ensures state integrity across collaborative environments or CI/CD workflows.

---

## 📚 Table of Content

- [Solution Overview](#solution-overview)  
- [Architecture Diagram](#architecture-diagram)  
- [Terraform Modules](#terraform-modules)  
- [Component Breakdown](#component-breakdown)  
- [Customizing the Solution](#customizing-the-solution)  
- [Prerequisites for Customization](#prerequisites-for-customization)  
  1. [Clone the Repository](#1-clone-the-repository)  
  2. [Initialize and Validate](#2-initialize-and-validate)  
  3. [Build & Deploy](#3-build--deploy)  
- [Monitoring & Alerts](#monitoring--alerts)  
- [Testing the Deployment](#testing-the-deployment)  
- [License](#license)

---

## 🧱 Terraform Modules

| Module          | Purpose                                                               |
|-----------------|-------------------------------------------------------------------------|
| `VPC`           | Networking setup (VPC, subnets, route tables, IGW, NAT)                 |
| `EC2`           | Bastion host and optional standalone web servers                        |
| `ASG`           | Auto Scaling Group with Launch Template and UserData                    |
| `ALB`           | Application Load Balancer setup and integration with target group       |
| `Security Group`| Defines layered security between bastion, web, ALB, and DB             |
| `DB`            | Amazon RDS MySQL deployment                                             |
| `CloudWatch`    | CPU alarms for EC2 in ASG                                               |
| `SNS`           | Sends email alerts on CloudWatch alarm trigger                          |
| `S3 Backend`    | Remote Terraform state management with S3 (optional DynamoDB)           |

---

## 🧩 Component Breakdown

(You can copy-paste from the previously structured detailed components section in your original doc.)

---

## ⚙️ Customizing the Solution

Adjust the following to fit your needs:
- Modify variables in `variables.tf`
- Replace UserData script (`config_file.sh.tpl`) for custom app stacks
- Customize ASG policies, DB instance class, or add encryption
- Update SNS topics or subscribe multiple emails

---

## 🛠 Prerequisites for Customization

### 1. Clone the Repository

```bash
git clone https://github.com/saramousa30/AWS-Multi-Tier-Architecture-using-Terraform.git
cd AWS-Multi-Tier-Architecture-using-Terraform
```

### 2. Initialize and Validate

```bash
terraform init
terraform validate
```

### 3. Build & Deploy

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

---

## 📈 Monitoring & Alerts

- CloudWatch tracks:
  - EC2 CPU metrics
  - Alarm triggered if threshold (e.g., 75%) exceeded
- SNS notifies via email (must confirm the subscription after deployment)

---

## 🧪 Testing the Deployment

- **ALB Access**:  
  Get the ALB DNS from EC2 > Load Balancers and open in browser  
  Example: `http://<your-alb-dns>`

- **SSH into Private EC2**:  
  SSH through bastion host:
  ```bash
  ssh -i my-key.pem ubuntu@<bastion-host-ip>
  ```

- **MySQL Connectivity** (from EC2 with mysql-client):
  ```bash
  mysql -h <rds-endpoint> -u <user> -p
  ```
---

> by Sara Mousa

---

## 📂 Documentation

[AWS Multi-Tier Architecture using Terraform](https://www.notion.so/AWS-Multi-Tier-Architecture-using-Terraform-1e82a9d6f04280b8815bdd81d7c4e342?pvs=4)
## 🔗 Links

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/saramousa3010/)

