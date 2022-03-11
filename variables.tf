variable "name" {}

variable "region" {
  description = "The AWS region things are created in"
}

variable "aws_account" {}

variable "docker_image" {
  description = "Docker image to run in the ECS cluster"
  default     = ""
}

variable "ecr_image" {
  description = "ECR AWS image to run in the ECS cluster"
  default     = ""
}

variable "desired_container_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "vpc_id" {}

variable "target_type" {
  default = "ip"
}

variable "protocol" {
  default = "HTTP"
}

variable "health_check_protocol" {
  default = "HTTP"
}

variable "health_check_port" {
  default = "3000"
}

variable "subnets" {
  default = []
}

variable "listener_port" {
  default = "443"
}

variable "listener_protocol" {
  default = "HTTPS"
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. map_environment overrides environment"
  default     = []
}


variable "container_memory" {
  type        = number
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = null
}

variable "container_memory_reservation" {
  type        = number
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = null
}

variable "container_cpu" {
  type        = number
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 0
}

variable "provisioned" {
  type        = string
  description = "Provisioned By"
  default     = "Terraform"
}

variable "environment" {}

variable "target_group_port" {
  default = "3000"
}

variable "health_check_interval" {
  default = "20"
}

variable "health_check_timeout" {
  default = "7"
}

variable "load_balancer_container_port" {
  default = "3000"
}

variable "cert_domain" {
  default = ""
}

variable "mantainer" {
  default = "OpsTeam"
}

variable "healthy_threshold" {
  default = "5"
}

variable "unhealthy_threshold" {
  default = "3"
}