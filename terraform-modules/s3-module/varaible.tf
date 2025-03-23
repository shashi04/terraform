variable "bucket_name" {
  description = "Name of the s3"
  type        = string
}

variable "block_public_acls" {
  description = "Block Public Access to ACL"
  type        = string
  default     = true
}