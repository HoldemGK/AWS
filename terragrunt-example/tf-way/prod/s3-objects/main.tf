data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "terraform-backend-gk"
    key    = "prod/s3/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "s3_object" {
  source  = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//modules/object"
  bucket  = data.terraform_remote_state.s3.outputs.id
  key     = var.file_name
  content = var.file_text
  tags    = var.tags
}