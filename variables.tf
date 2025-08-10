variable "project" {
  description = "name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc cidr block range"
  type        = string
}

variable "subnet_cidr" {
  description = "subnet cidr block range"
  type        = string
}

variable "availability_zone" {
  description = "availability zone name"
  type        = string
}
