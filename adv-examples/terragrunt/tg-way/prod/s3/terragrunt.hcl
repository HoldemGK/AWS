include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git//."
}

inputs = {
  bucket = "gk-tg-test-bucket-prod"
  tags = {
    Owner = "GK"
    Env   = "prod"
  }
}