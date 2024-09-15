provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-gk"
    key    = "prod/pm_grf.tfstate"
  }
}
