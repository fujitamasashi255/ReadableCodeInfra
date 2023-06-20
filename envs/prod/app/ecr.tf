module "rails" {
  source = "../../../modules/ecr"

  name = "readablecoder-prod-rails"

  tags = {
    Name = "readablecoder-prod-rails"
  }
}

module "nginx" {
  source = "../../../modules/ecr"

  name = "readablecoder-prod-nginx"

  tags = {
    Name = "readablecoder-prod-nginx"
  }
}
