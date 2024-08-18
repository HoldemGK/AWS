provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-gk"
    key    = "prod/terraform.tfstate"
  }
}
