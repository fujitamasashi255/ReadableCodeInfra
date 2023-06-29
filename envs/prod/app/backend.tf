terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/app.tfstate"
    region = "ap-northeast-1"
  }
}
