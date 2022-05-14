/*
Local:
---------
terraform apply -var-file="secrets.tfvars"
terraform destroy -var-file="secrets.tfvars"

Cloud (remote):
------------------
terraform login <--- redirected to browser to generate token (if you don't have one)
Also, make sure to have a cloud workspace set up

In the configs (upon not using local state anymore) we need to add the following AWS credentials environment variables:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

terraform apply
terraform destroy
*/

resource "random_pet" "sg" {}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  # subnet_id   = "subnet-049bfaf491d620409"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOT
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
  EOT
}

# Declare ports for our web server
resource "aws_security_group" "web-sg" {
  name = "${random_pet.sg.id}-sg"

  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get the web address (to hit)
output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}