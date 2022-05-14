/*
terraform init

Local way:
---------
terraform apply -var-file="secrets.tfvars"
terraform destroy -var-file="secrets.tfvars"

Cloud (remote) way:
------------------
terraform login <--- redirected to browser to generate token (if you don't have one)
Also, make sure to have a cloud workspace set up

In the configs (upon not using local state anymore) we need to add the following AWS credentials environment variables:
AWS_ACCESS_KEY
AWS_SECRET_ACCESS_KEY

terraform apply
terraform destroy
*/

// Added for Terraform Cloud to manage backend state instead of local state
terraform {
  backend "remote" {
    organization = "backwards"

    workspaces {
      name = "my-cli-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }
  }
}

provider "aws" {
  /*
  No longer required upon moving from local to cloud state
  access_key  = var.access_key
  secret_key  = var.secret_key
  */
  region = var.region
}

resource "aws_instance" "vm" {
  ami           = "ami-00db75007d6c5c578"
  subnet_id     = "subnet-049bfaf491d620409"
  instance_type = "t3.micro"

  tags = {
    Name = "my-first-tf-node"
  }
}