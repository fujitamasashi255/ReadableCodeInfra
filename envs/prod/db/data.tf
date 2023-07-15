data "aws_kms_alias" "rds" {
  name = "alias/aws/rds"
}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "readable-coder-tfstate"
    key    = "${local.env_name}/network/main.tfstate"
    region = "ap-northeast-1"
  }
}