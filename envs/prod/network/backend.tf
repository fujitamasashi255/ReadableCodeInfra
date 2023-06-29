terraform {
  backend "s3" {
    bucket = "lets-readable-code-tfstate"
    key    = "prod/network.tfstate"
    region = "ap-northeast-1"
  }
}
