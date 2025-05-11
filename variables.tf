variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "lambda_authorizer_invoke_arn" {
  description = "Lambda authorizer invoke ARN"
  type        = string
}
