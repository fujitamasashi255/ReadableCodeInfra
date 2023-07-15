terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/log/db.tfstate"
    region = "ap-northeast-1"
  }
}