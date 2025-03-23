terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

provider "aws" {
  region = "ap-south-1"
}

# ✅ Remote state storage in S3

  backend "s3" { 
    bucket         = "terraformiacstatefile"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}


# ✅ Step 1: Generate an SSH Key Pair

resource "tls_private_key" "sshkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ✅ Step 2: Save the SSH Private Key Locally

resource "local_file" "private_key" {
  content  = tls_private_key.sshkey.private_key_pem
  filename = "/home/ubuntu/.ssh/id_rsa"
}

# ✅ Step 3: Create an AWS Key Pair using the Generated SSH Key

resource "aws_key_pair" "generated" {
  key_name   = "terraform-key-${terraform.workspace}"
  public_key = tls_private_key.sshkey.public_key_openssh
}

# ✅ Step 4: Create an EC2 Instance with the Generated Key

module "web_server" {
  source        = "../terraform-modules/ec2-instance"
  instance_name = "MyWebServer-${terraform.workspace}"
  instance_type = "t2.micro"
  ami_id        = "ami-00bb6a80f01f03502"
  key_name      = aws_key_pair.generated.key_name
  private_key   = tls_private_key.sshkey.private_key_pem
}