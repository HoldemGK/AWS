provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-gk"
    key    = "prod/k8s.tfstate"
  }
}
