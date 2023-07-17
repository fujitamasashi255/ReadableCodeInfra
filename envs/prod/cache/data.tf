data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "readable-coder-tfstate"
    key    = "prod/network/main.tfstate"
    region = "ap-northeast-1"
  }
}