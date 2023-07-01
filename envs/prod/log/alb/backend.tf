terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/log/alb.tfstate"
    region = "ap-northeast-1"
  }
}
