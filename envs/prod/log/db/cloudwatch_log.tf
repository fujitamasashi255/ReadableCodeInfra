resource "aws_cloudwatch_log_group" "error" {
  name = "/aws/rds/instance/${local.name_prefix}/error"

  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "general" {
  name = "/aws/rds/instance/${local.name_prefix}/general"

  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "slowquery" {
  name = "/aws/rds/instance/${local.name_prefix}/slowquery"

  retention_in_days = 7
}