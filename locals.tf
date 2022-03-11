locals {
  log_name   = join("-", ["/ecs/task-definition", var.environment, var.name])
  stack_name = join("-", [var.environment, var.name]) 
  ecr_image  = "${var.aws_account}.dkr.ecr.${var.region}.amazonaws.com/${var.image}" 
}
