/*
Not required as we are using cloud state (with Terraform Cloud) instead of local state

variable "access-key" {
  type      = string
  sensitive = true
}

variable "secret-key" {
  type      = string
  sensitive = true
}
*/

variable "AWS_ACCOUNT_ID" {
  type = string
}

variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}