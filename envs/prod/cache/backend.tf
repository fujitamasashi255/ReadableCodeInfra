terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/cache.tfstate"
    region = "ap-northeast-1"
  }
}
