resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name # Change this to a globally unique name

  tags = {
    Name        = "Terraform State Bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
