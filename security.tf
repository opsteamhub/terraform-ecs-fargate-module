# security.tf

# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "lb" {
  name        = join("-", ["SG_LB", replace(local.stack_name, "ecs-", "")])
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id


  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name          = join("-", ["SG_LB", replace(local.stack_name, "ecs-", "")])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Mantainer     = var.mantainer
  }

}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = join("-", ["SG_TASK", replace(local.stack_name, "ecs-", "")])
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name          = join("-", ["SG_TASK", replace(local.stack_name, "ecs-", "")])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
    Mantainer     = var.mantainer
  }

}

