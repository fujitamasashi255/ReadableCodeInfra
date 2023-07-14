terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/db.tfstate"
    region = "ap-northeast-1"
  }
}