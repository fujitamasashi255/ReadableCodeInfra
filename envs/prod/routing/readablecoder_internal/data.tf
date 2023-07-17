data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "readable-coder-tfstate"
    key    = "prod/network/main.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "db_readablecoder" {
  backend = "s3"

  config = {
    bucket = "readable-coder-tfstate"
    key    = "prod/db.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "cache_readablecoder" {
  backend = "s3"

  config = {
    bucket = "readable-coder-tfstate"
    key    = "prod/cache.tfstate"
    region = "ap-northeast-1"
  }
}