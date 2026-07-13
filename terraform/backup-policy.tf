resource "aws_iam_policy" "mongodb_backup" {

  name = "mongodb-backup-policy"

  description = "Allow MongoDB EC2 to upload backups to S3"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "BucketAccess"

        Effect = "Allow"

        Action = [

          "s3:ListBucket",

          "s3:GetBucketLocation"

        ]

        Resource = [

          aws_s3_bucket.mongodb_backup.arn

        ]

      },

      {

        Sid = "ObjectAccess"

        Effect = "Allow"

        Action = [

          "s3:PutObject",

          "s3:GetObject"

        ]

        Resource = [

          "${aws_s3_bucket.mongodb_backup.arn}/*"

        ]

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "mongodb_backup" {

  role = aws_iam_role.mongodb_role.name

  policy_arn = aws_iam_policy.mongodb_backup.arn

}