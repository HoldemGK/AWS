variable "file_name" {
  default = "test_file.txt"
}

variable "file_text" {
  default = "Hello, this is test"
}

variable "tags" {
  default = {
    Owner = "GK"
    Env   = "root"
  }
}