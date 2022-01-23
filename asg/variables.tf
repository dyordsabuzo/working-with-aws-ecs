variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for launch template"
  default     = "t3a.micro"
}

variable "nginx_port" {
  type        = string
  description = "Nginx port"
  default     = 80
}

variable "cluster_name" {
  type        = string
  description = "ECS cluster name"
}

