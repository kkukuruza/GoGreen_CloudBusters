resource "aws_db_subnet_group" "go_green" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "go_green_db" {
  identifier              = var.identifier
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.go_green.name
  vpc_security_group_ids  = var.security_group_db_id
  kms_key_id              = var.kms_key_arn
  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
}


resource "aws_s3_bucket" "rds_snapshots" {
  bucket = "go-green-rds-snapshots-4-hours"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  policy_arn = aws_iam_role_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:CreateDBSnapshot",
          "rds:DeleteDBSnapshot",
          "rds:CopyDBSnapshot",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.8"

  environment {
    variables = {
      RDS_INSTANCE_IDENTIFIER = "gogreendb"
      S3_BUCKET_NAME          = aws_s3_bucket.rds_snapshots.id
    }
  }
}

resource "aws_cloudwatch_event_rule" "rpo" {
  name                = "rpo_event_rule"
  schedule_expression = "rate(4 hours)"
}

resource "aws_cloudwatch_event_target" "rpo_cloudwatch" {
  rule      = aws_cloudwatch_event_rule.rpo.name
  target_id = "rpo_event_target"
  arn       = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "lambda_permission"
  action        = "lambda:InvokeFunction"
  function_name = "lambda_function"
  principal     = "events.amazonaws.com"
  source_arn    = aws_lambda_function.lambda_function.arn
}