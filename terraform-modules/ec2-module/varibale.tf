variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "key_name" {
  description = "SSH Key for the instance"
  type        = string
}

variable "private_key" {
  description = "Private key for SSH access"
  type        = string
  sensitive   = true  # Hide value in Terraform output
}