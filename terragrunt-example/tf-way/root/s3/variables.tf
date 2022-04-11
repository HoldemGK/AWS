variable "bucket_name" {
  default = "gk-tf-test-bucket-root"
}

variable "tags" {
  default = {
    Owner = "GK"
    Env   = "root"
  }
}