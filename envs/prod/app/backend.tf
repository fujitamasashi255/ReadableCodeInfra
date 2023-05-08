terraform {
  backend "s3" {
    bucket = "lets-readable-code-tfstate"
    key    = "prod/app.tfstate"
    region = "ap-northeast-1"
  }
}
