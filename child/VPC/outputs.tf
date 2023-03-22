output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private_subnet_3.id
}

output "private_subnet_4_id" {
  value = aws_subnet.private_subnet_4.id
}

output "private_subnet_5_id" {
  value = aws_subnet.private_subnet_5.id
}

output "private_subnet_6_id" {
  value = aws_subnet.private_subnet_6.id
}

output "security_group_ids" {
  value = [
    aws_security_group.alb_sg.id,
    aws_security_group.web_sg.id,
    aws_security_group.alb_private_sg.id,
    aws_security_group.app_sg.id,
    aws_security_group.db_sg.id
 ]
}

output "VPC_id" {
  value = aws_vpc.go_green_vpc.id
}