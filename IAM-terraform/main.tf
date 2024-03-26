provider "aws" {
  region = var.region
}

resource "aws_iam_role" "team_role" {
  name = "team-eks-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::637423247328:user/karv-user"]
          # Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "team_policy" {
  name        = "team_policy"
  path        = "/"
  description = "Team Karv policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "team_policy_attachment" {
  role = aws_iam_role.team_role.name
  policy_arn = aws_iam_policy.team_policy.arn
}