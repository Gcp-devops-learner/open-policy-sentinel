# Terraform 
This script contains code to deploy a Network, subnet, firewall rule and a compute engine machine.



# VPC Module
This module allows you to create a VPC network in the project.It also accepts input for routing mode and subnet

## Features

This module will take the following actions

1. Create a new VPC network in the project `module.project.project_id`
1. Accepts an array of Subnet
1. Accepts an array of Secondary ranges for the subnet

# Firewall rules

This module allows you to create firewall rules in the VPC network

This module will take the following actions

1. This modules accepts a array object for the firewall rules to be created in the project `module.project.project_id`

# Compute Engine

This resource block allows you to create a compute engine VM.

This resource will take the following actions

1. This resource block creates a Compute Engine VM with windows server 2022
1. Create a VM with external IP address
1. Add a tag to the machine

# Access required

User can authenticate via a service account or use `gcloud auth login` command in their local environment. The best practice is to run terrform scripts on GCP VM and attach the service accounts to the VM, so users doesnt have to manage the service account keys. 

Access required

Billing Account Administrator
Organization Administrator
Project Creator
Owner

# Terraform commands

### Initialise terraform with the modules and backend configuration 
`terraform init`
### Terraform plans the deployment and output the resources to add and configure but doenst deploy any resources
`terraform plan -out plan.out`
### terraform deploys the reosurces
`terraform apply plan.out`
### Clear the deployed resources 
`terraform destroy`
