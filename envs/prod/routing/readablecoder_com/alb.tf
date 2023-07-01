resource "aws_lb" "this" {
  count = var.enable_alb ? 1 : 0

  name = "readablecoder-com"

  internal           = false
  load_balancer_type = "application"

  security_groups = [
    data.terraform_remote_state.network_main.outputs.security_group_web_id,
    data.terraform_remote_state.network_main.outputs.security_group_vpc_id,
  ]
  subnets = [
    for s in data.terraform_remote_state.network_main.outputs.subnet_public : s.id
  ]

  tags = {
    Name = "${local.name_prefix}-readablecoder-com"
  }
}
