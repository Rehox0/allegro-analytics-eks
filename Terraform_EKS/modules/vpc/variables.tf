variable "common_tags" {
  description = "Tags passed from the environment"
  type        = map(string)
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR list for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR list for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}
