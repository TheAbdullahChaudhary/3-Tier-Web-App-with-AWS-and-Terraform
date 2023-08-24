# 3-Tier-Web-App-with-AWS-and-Terraform
In this repo, I  share source code that I've built a three-tier AWS VPC network architecture using Terraform.
This network architecture has three subnet tiers split across two availability zones. The web subnets also have a VPC routing table that will provide access to the internet. The application and database tiers will not have such access; their routing tables will only allow internal network communication.

**Prerequisites**
You should have the Terraform CLI setup on your computer.

**Create Directories & Files**
Next, create a baseline directory and file structure as follows.

abdullah-3-tier-app/
├── main.tf
├── outputs.tf
└── variables.tf
└── env/
    └──dev.tfvars


    
