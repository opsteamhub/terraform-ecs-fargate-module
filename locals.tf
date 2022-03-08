locals {
  log_name   = join("-", ["/ecs/task-definition", var.environment, var.name])
  stack_name = join("-", [var.environment, var.name])  
}
