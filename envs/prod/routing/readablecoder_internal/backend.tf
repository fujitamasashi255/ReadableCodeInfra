terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/routing/readablecoder_internal.tfstate"
    region = "ap-northeast-1"
  }
}