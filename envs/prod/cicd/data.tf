data "aws_ecs_service" "this" {
  cluster_arn  = local.name_prefix
  service_name = local.name_prefix
}