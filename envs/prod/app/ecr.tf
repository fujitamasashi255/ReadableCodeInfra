resource "aws_ecr_repository" "rails" {
  name = "prod-rails"

  tags = {
    Name = "prod-rails"
  }
}

resource "aws_ecr_lifecycle_policy" "rails" {
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only 10 images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : 10
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.rails.name
}
