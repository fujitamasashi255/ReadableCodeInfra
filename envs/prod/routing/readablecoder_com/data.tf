data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = local.backend_bucket_name
    key    = "${local.env_name}/network/main.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "log_alb" {
  backend = "s3"

  config = {
    bucket = local.backend_bucket_name
    key    = "${local.env_name}/log/alb.tfstate"
    region = "ap-northeast-1"
  }
}