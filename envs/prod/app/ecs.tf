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
            containerPath = "/app/sockets"
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
        secrets     = []

        mountPoints = [
          {
            containerPath = "/app/sockets"
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
