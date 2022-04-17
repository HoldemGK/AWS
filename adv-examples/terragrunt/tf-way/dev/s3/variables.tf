variable "bucket_name" {
  default = "gk-tf-test-bucket-dev"
}

variable "tags" {
  default = {
      Owner = "GK"
      Env = "dev"
  }
}