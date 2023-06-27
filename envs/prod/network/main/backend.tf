terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/network/main.tfstate"
    region = "ap-northeast-1"
  }
}
