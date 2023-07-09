resource "aws_iam_user" "github" {
  name = "prod-github"

  tags = {
    Name = "prod-github"
  }
}

resource "aws_iam_role" "deployer" {
  name = "prod-deployer"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole",
            "sts:TagSession"
          ],
          "Principal" : {
            "AWS" : aws_iam_user.github.arn
          }
        }
      ]
    }
  )

  tags = {
    Name = "prod-deployer"
  }
}

data "aws_iam_policy" "ecr_power_user" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "role_deployer_policy_ecr_power_user" {
  role       = aws_iam_role.deployer.name
  policy_arn = data.aws_iam_policy.ecr_power_user.arn
}

resource "aws_iam_role_policy" "s3" {
  name = "s3"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject"
          ],
          "Resource" : "arn:aws:s3:::readable-coder-tfstate/${local.app_name}/${local.env_name}/cicd.tfstate"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecs" {
  name = "ecs"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "RegisterTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "ecs:RegisterTaskDefinition"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "PassRolesInTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "iam:PassRole"
          ],
          "Resource" : [
            data.aws_iam_role.ecs_task.arn,
            data.aws_iam_role.ecs_task_execution.arn,
          ]
        },
        {
          "Sid" : "DeployService",
          "Effect" : "Allow",
          "Action" : [
            "ecs:UpdateService",
            "ecs:DescribeServices"
          ],
          "Resource" : [
            data.aws_ecs_service.this.arn
          ]
        }
      ]
    }
  )
}