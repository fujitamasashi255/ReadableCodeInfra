data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = local.backend_bucket_name
    key    = "prod/network/main.tfstate"
    region = "ap-northeast-1"
  }
}