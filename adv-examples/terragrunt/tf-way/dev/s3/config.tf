terraform {
  backend "s3" {
      bucket = "terraform-backend-gk"
      key = "dev/s3/terraform.tfstate"
      region = "eu-north-1"
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = data.vault_generic_secret.aws_creds.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_creds.data["aws_secret_access_key"]
}

data "vault_generic_secret" "aws_creds" {
  path = "secret/aws"
}