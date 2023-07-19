data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "aws_ecs_cluster" "this" {
  cluster_name = local.name_prefix
}

data "aws_ecs_service" "this" {
  cluster_arn  = local.name_prefix
  service_name = local.name_prefix
}