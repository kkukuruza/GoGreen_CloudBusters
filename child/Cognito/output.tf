output "user_pool_id" {
  value       = aws_cognito_user_pool.gogreen_cognito.id
  description = "The ID of the created Cognito User Pool"
}

output "user_pool_client_id" {
  value       = aws_cognito_user_pool_client.gogreen_cognito.id
  description = "The ID of the created Cognito User Pool App Client"
}