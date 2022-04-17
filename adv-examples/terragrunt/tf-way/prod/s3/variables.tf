variable "bucket_name" {
  default = "gk-tf-test-bucket-prod"
}

variable "tags" {
  default = {
    Owner = "GK"
    Env   = "prod"
  }
}