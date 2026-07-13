resource "aws_iam_role" "mongodb_role" {
  name = "mongodb-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "mongodb_profile" {
  name = "mongodb-profile"
  role = aws_iam_role.mongodb_role.name
}

