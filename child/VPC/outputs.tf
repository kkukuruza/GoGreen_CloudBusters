output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "private_subnet3_id" {
  value = aws_subnet.private_subnet3.id
}

output "private_subnet4_id" {
  value = aws_subnet.private_subnet4.id
}

output "private_subnet5_id" {
  value = aws_subnet.private_subnet5.id
}

output "private_subnet6_id" {
  value = aws_subnet.private_subnet6.id
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