resource "aws_alb" "main" {
  name            = replace(local.stack_name, "ecs-", "")
  subnets         = var.subnets
  security_groups = [aws_security_group.lb.id]

  tags = {
    Name          = join("-", [var.environment, var.name])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
  }

}

resource "aws_alb_target_group" "app" {
  name        = join("-", [var.environment, var.name])
  port        = var.target_group_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    interval = var.health_check_interval
    protocol = var.health_check_protocol
    port     = var.health_check_port
    timeout  = var.health_check_timeout
    path     = var.health_check_path
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name          = join("-", [var.environment, var.name])
    ProvisionedBy = var.provisioned
    Environment   = var.environment
  }

}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "default" {
  load_balancer_arn = aws_alb.main.id
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.issued.arn

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

