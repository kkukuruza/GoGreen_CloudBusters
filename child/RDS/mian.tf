resource "aws_db_subnet_group" "go_green" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "go_green_db" {
  identifier           = "gogreendb"
  allocated_storage    = 6144 
  storage_type         = var.storage_type
  engine               = "mysql"
  engine_version       = "5.7.41"
  instance_class       = var.instance_class
  db_name              = "admin"
  username             = "admin"
  password             = "gogreen2023"
  db_subnet_group_name = aws_db_subnet_group.go_green.name
  vpc_security_group_ids = var.security_group_db_id
  kms_key_id           = var.kem_key_arn
  multi_az             = true
  publicly_accessible  = false
  backup_retention_period = 0
  skip_final_snapshot  = true
}