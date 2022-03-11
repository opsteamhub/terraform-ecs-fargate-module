resource "aws_ecs_cluster" "main" {
  name = replace(local.stack_name, "ecs-", "")
 
  tags = {
    Name          = replace(local.stack_name, "ecs-", "")
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Mantainer     = var.mantainer
  }
  
}

resource "aws_ecs_task_definition" "default" {
  family                   = join("-", ["td", replace(local.stack_name, "ecs-", "")])
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = module.container.json_map_encoded_list

}

resource "aws_ecs_service" "main" {
  name            = join("-", ["serv", replace(local.stack_name, "ecs-", "")])
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.default.arn
  desired_count   = var.desired_container_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = var.name
    container_port   = var.load_balancer_container_port
  }

  tags = {
    Name          = join("-", ["serv", replace(local.stack_name, "ecs-", "")])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Mantainer     = var.mantainer
  }

  depends_on = [aws_alb_listener.default, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

