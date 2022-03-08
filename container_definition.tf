module "container" {
  source                       = "github.com/opsteamhub/terraform-aws-ecs-container-definition"
  container_name               = var.name
  container_image              = "${var.aws_account}.dkr.ecr.${var.region}.amazonaws.com/${var.image}"
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_cpu                = var.container_cpu
  environment                  = var.container_environment
  port_mappings = [
   {
    containerPort = 3000
    hostPort      = 3000
    protocol      = "tcp"
   }
  ]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group": "${local.log_name}",
      "awslogs-region": "${var.region}",
      "awslogs-stream-prefix": "ecs"
    }
    secretOptions = null
   }

}

