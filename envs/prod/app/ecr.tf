module "rails" {
  source = "../../../modules/ecr"

  name = "${local.name_prefix}-rails"
}

module "nginx" {
  source = "../../../modules/ecr"

  name = "${local.name_prefix}-nginx"
}
