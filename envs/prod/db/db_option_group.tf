resource "aws_db_option_group" "this" {
  name = "${local.app_name}-${local.env_name}"

  engine_name          = "mysql"
  major_engine_version = "8.0"

  tags = {
    Name = "${local.app_name}-${local.env_name}"
  }
}