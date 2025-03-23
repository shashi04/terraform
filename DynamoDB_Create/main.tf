module "dynamodb_table" {
  source        = "../terraform-modules/dynamodb-module"
  region        = "ap-south-1"
  name          = "terraform-locks"
}