locals {
  name_prefix         = "${local.app_name}-${local.env_name}"
  app_name            = "readable-coder"
  env_name            = "prod"
  backend_bucket_name = "readable-coder-tfstate"
}
