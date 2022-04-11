# Generate backend.tf file with remote state config
remote_state {
    backend = "s3"
    generate = {
        path = "_backend.tf"
        if_exists = "overwrite"
    }
    config = {
        bucket = "terragrunt-backend-gk"
        region = "eu-north-1"
        key = "${path_relative_to_include}/terraform.tfstate"
        encrypt = true
    }
}

# Generate config.tf file with provider config
generate "my_config" {
    path = "_config.tf"
    if_exists = "overwrite"

    contents = <<EOF
provider "aws" {
  region     = var.aws_region
  access_key = data.vault_generic_secret.aws_creds.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_creds.data["aws_secret_access_key"]
}

data "vault_generic_secret" "aws_creds" {
  path = var.path_secret_aws
}

variable "aws_region" {}
variable "path_secret_aws" {}
EOF
}

# Load variables
terraform {
    extra_erguments "common_vars" {
        commands = get_terraform_commands_that_need_vars()
        required_var_files = [
            find_in_parent_folders("common.tfvars")
        ]
    }
}