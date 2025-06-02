 3-Tier Architecture Deployment on AWS using Terraform
This project demonstrates the deployment of a 3-tier architecture on AWS using Terraform. It includes the setup of a custom Virtual Private Cloud (VPC), subnets, route tables, internet gateway, and EC2 instances across different layers (web, application, and database), following cloud infrastructure best practices.

🌐 Architecture Overview
The infrastructure is logically divided into three tiers:

Presentation Layer (Web Tier)
Hosts the web servers in a public subnet accessible via the internet gateway.

Application Layer (App Tier)
Contains EC2 instances in a private subnet with no direct internet access, facilitating business logic processing.

Data Layer (Database Tier)
Encloses databases in isolated private subnets with tightly controlled access.

📦 Key Components
VPC & Subnets: Custom VPC (10.1.0.0/16) with public and private subnets.

Internet Gateway: Attached to the VPC for public subnet access.

Route Tables: Configured for routing traffic from the public subnet to the internet.

EC2 Instances: Deployed within the designated subnets.

(Optional/Commented) NAT Gateway, Bastion Host, and additional routing for private-to-public communication.

⚙️ Technologies Used
Terraform v1.x

AWS Provider v5.39.0

Amazon EC2

Amazon VPC and related networking services
