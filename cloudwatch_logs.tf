resource "aws_cloudwatch_log_group" "main" {
  name              = local.log_name
  retention_in_days = 1

  tags = {
    Name          = local.log_name
    ProvisionedBy = var.provisioned
    Environment   = var.environment
  }
}