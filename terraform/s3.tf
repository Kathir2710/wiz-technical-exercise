resource "aws_s3_bucket" "mongodb_backup" {
  bucket = "wiz-mongodb-backup-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "MongoDB Backup"
    Environment = "dev"
    Project     = "wiz-tech-exercise"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_versioning" "backup" {
  bucket = aws_s3_bucket.mongodb_backup.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup" {

  bucket = aws_s3_bucket.mongodb_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}