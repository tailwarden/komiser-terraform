resource "aws_iam_policy" "komiser_policy" {
  name        = "komiser_policy"
  description = "Komiser recommended IAM policy"

  policy = file("policy.json")
}

resource "aws_iam_role" "komiser_role" {
  name = "komiser_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "komiser_attach_policy" {
  name       = "komiser_attach_policy"
  roles      = [aws_iam_role.komiser_role.name]
  policy_arn = aws_iam_policy.komiser_policy.arn
}

resource "aws_iam_instance_profile" "komiser_instance_profile" {
  name = "komiser_instance_profile"
  role = aws_iam_role.komiser_role.name
}