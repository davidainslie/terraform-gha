/*
Not required as we are using cloud state (with Terraform Cloud) instead of local state

variable "aws-access-key-id" {
  type      = string
  sensitive = true
}

variable "aws-secret-access-key" {
  type      = string
  sensitive = true
}
*/

variable "aws-region" {
  type    = string
  default = "us-east-1"
}