terraform {
  backend "s3" {
    bucket = "readable-coder-tfstate"
    key    = "prod/log/readablecoder_com.tfstate"
    region = "ap-northeast-1"
  }
}
