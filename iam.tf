resource "aws_iam_group" "developers" {
  name = "cmtr-o84gfl9h-iam-group"
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = "S3WriteOnlyPolicy"
  description = "Allows only write (Put/Delete) access to a specific S3 bucket"

  # Inject the variable into the template file
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket_name
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "cmtr-o84gfl9h-iam-role"

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

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}
