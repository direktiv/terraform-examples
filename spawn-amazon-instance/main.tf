terraform {
    backend "http" {}
}

provider "aws" {
  region = "us-east-2"
  access_key = var.amazon_access_key
  secret_key = var.amazon_secret_key
}

variable "amazon_access_key" {
  description = "amazon_access_key to use for authentication"
}

variable "amazon_secret_key" {
  description = "amazon_secret_key to use for authentication"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "ip-address" {
    value = aws_instance.web.public_ip
}

