resource "aws_elasticache_parameter_group" "this" {
  name = "${local.app_name}-${local.env_name}"

  family = "redis7"
}