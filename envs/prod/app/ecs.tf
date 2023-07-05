resource "aws_ecs_cluster" "this" {
  name = local.name_prefix

  tags = {
    Name = local.name_prefix
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]
}

resource "aws_ecs_task_definition" "this" {
  family = local.name_prefix

  task_role_arn = aws_iam_role.ecs_task.arn

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE",
  ]

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  memory = "512"
  cpu    = "256"

  container_definitions = jsonencode(
    [
      {
        name  = "nginx"
        image = "${module.nginx.ecr_repository_this_repository_url}:latest"

        portMappings = [
          {
            containerPort = 80
            protocol      = "tcp"
          }
        ]

        environment = []
        secrets     = []

        dependsOn = [
          {
            containerName = "rails"
            condition     = "START"
          }
        ]

        mountPoints = [
          {
            containerPath = "/app/tmp/sockets"
            sourceVolume  = "puma-socket"
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/${local.name_prefix}/nginx"
            awslogs-region        = data.aws_region.current.id
            awslogs-stream-prefix = "ecs"
          }
        }
      },
      # end of nginx
      {
        name  = "rails"
        image = "${module.rails.ecr_repository_this_repository_url}:latest"

        portMappings = []

        environment = []
        secrets = [
          {
            name      = "RAILS_MASTER_KEY"
            valueFrom = "/${local.app_name}/${local.env_name}/RAILS_MASTER_KEY"
          }
        ]

        mountPoints = [
          {
            containerPath = "/app/tmp/sockets"
            sourceVolume  = "puma-socket"
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/${local.name_prefix}/rails"
            awslogs-region        = data.aws_region.current.id
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )

  volume {
    name = "puma-socket"
  }

  tags = {
    Name = local.name_prefix
  }
}

resource "aws_ecs_service" "this" {
  name = local.name_prefix

  cluster = aws_ecs_cluster.this.arn

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base              = 0
    weight            = 1
  }

  platform_version = "1.4.0"

  task_definition = aws_ecs_task_definition.this.arn

  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  load_balancer {
    container_name   = "nginx"
    container_port   = 80
    target_group_arn = data.terraform_remote_state.routing_readablecoder_com.outputs.lb_target_group_readablecoder_arn
  }

  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups = [
      data.terraform_remote_state.network_main.outputs.security_group_vpc_id
    ]
    subnets = [
      for s in data.terraform_remote_state.network_main.outputs.subnet_private : s.id
    ]
  }

  enable_execute_command = true

  tags = {
    Name = local.name_prefix
  }
}