resource "aws_cloudwatch_log_group" "nginx" {
  name = "/ecs/${local.name_prefix}/nginx"

  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "rails" {
  name = "/ecs/${local.name_prefix}/rails"

  retention_in_days = 14
}