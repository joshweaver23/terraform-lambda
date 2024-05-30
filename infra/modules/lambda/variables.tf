variable "ns" {
  description = "Namespace to add to resource names"
  type        = string
}

variable "name" {
  description = "Resource name"
  type        = string
}

variable "tags" {
  description = "Tags to add to all resources"
  type        = map(string)
}

variable "description" {
  description = "Lambda description"
  type        = string
}

variable "alias" {
  description = "Alias Configuration"
  type = object({
    name        = string
    description = string
  })
  default = {
    name        = "main"
    description = "Production alias"
  }
}

variable "role_arn" {
  type        = string
  description = "Role to attach to Lambda function"
}

variable "log_retention" {
  type    = number
  default = 1
}

variable "timeout" {
  type    = number
  default = 300
}

variable "memory" {
  type    = number
  default = 128
}

variable "vpc" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
}
