variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "base_domain" {
  type        = string
  description = "Base domain"
}

variable "nginx_port" {
  type        = number
  description = "NGINX container port"
  default     = 80
}

variable "target_type" {
  type        = string
  description = "Target type for load balancer target group"
  default     = "ip"
}
