## What this project does

This project is a Terraform-based AWS infrastructure deployment that automates the setup of a complete cloud environment.

It provisions a custom VPC, subnets, security groups, and an EC2 instance on AWS. The EC2 instance automatically installs and runs a Flask web application using a user_data.sh script during launch.

The project also demonstrates real-world DevOps practices such as infrastructure as code (IaC), automated provisioning, and application deployment on cloud infrastructure.


## Problems I solved (debugging)

1. Flask installation was failing because python3-pip was not installed in the user_data.sh script. Only python3 was being installed, but pip is not available by default on Ubuntu. This caused the error: ModuleNotFoundError: No module named 'flask'. The issue was fixed by explicitly adding apt install python3-pip -y to the script. 

2. The Flask service failed to start and the logs (journalctl) showed that the application was unable to bind to port 80 due to permission restrictions. The root cause was that the service was running under the ubuntu user, and on Linux systems only the root user (or privileged processes) can bind to ports below 1024.

To fix this issue, the application was changed to run on port 5000 instead of port 80, and the AWS Security Group was updated to allow inbound traffic on port 5000.

## Architecture

Architecture (Traffic Flow)
Internet users access the application via public IP / DNS
Traffic enters AWS through the Internet Gateway (IGW)
IGW routes requests to the public subnet inside the VPC
The EC2 instance (running Flask app) receives the request
Flask app processes the request and returns the response back through the same path
Connection Flow Summary

Internet → Internet Gateway → VPC Public Subnet → EC2 Instance → Flask Application

## How to deploy

Deployment steps:

1. Clone the repository
2. Create terraform.tfvars file with your values
3. Run terraform init
4. Run terraform plan (review what will be created)
5. Run terraform apply (type 'yes' to confirm)

Verification:

curl http://<public-ip>:5000
curl http://<public-ip>:5000/health

## Live demo (screenshot ya curl output)
<img width="1039" height="96" alt="app-running" src="https://github.com/user-attachments/assets/9f6d5173-8701-4f8b-8c27-846c07837e19" />
