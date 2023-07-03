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

data "terraform_remote_state" "routing_readablecoder_com" {
  backend = "s3"

  config = {
    bucket = local.backend_bucket_name
    key    = "prod/routing/readablecoder_com.tfstate"
    region = "ap-northeast-1"
  }
}