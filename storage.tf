resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "cmtr-o84gfl9h"
  }
}
