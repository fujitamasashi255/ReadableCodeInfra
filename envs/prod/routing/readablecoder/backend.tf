terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/routing/readablecoder.tfstate"
    region = "ap-northeast-1"
  }
}
