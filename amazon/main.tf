terraform {
    backend "http" {}
}

provider "aws" {
  region = var.region
  access_key = var.amazon_key
  secret_key = var.amazon_key
}

variable "region" {
  description = "the region you wish to use aws on"
}

variable "amazon_key" {
  description = "amazon_access_key to use for authentication"
}

variable "amazon_secret" {
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
}

output "ip-address" {
    value = aws_instance.web.public_ip
}

