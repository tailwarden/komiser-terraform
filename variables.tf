variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-central-1"
}

variable "instance_type" {
  type        = string
  description = "Komiser EC2 instance type"
  default     = "t2.medium"
}

variable "key" {
  type        = string
  description = "SSH key pair"
}

variable "owner" {
  type        = string
  description = "Infrastructure creator"
  default     = "mlabouardy"
}

variable "private_key_path" {
  type        = string
  description = "Path to AWS key pair"
}

variable "ssl_arn" {
  type        = string
  description = "ACM certificate ARN"
}

variable "subnets" {
  type        = list(any)
  description = "Subnets IDs where Komiser will be deployed"
}

variable "domain_name" {
  type        = string
  description = "Route53 domain name"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route53 zone ID"
}
