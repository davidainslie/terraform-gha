terraform {
  backend "remote" {
    organization = "backwards"

    workspaces {
      name = "github-actions-demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
}

provider "aws" {
  /*
  Not required as we are using cloud state (with Terraform Cloud) instead of local state
  access_key  = var.access_key
  secret_key  = var.secret_key
  */
  region = var.AWS_REGION
}