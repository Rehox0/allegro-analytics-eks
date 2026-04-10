variable "cluster_name" { type = string }
variable "cluster_endpoint" { type = string }
variable "cluster_ca_certificate" { type = string }
variable "alb_controller_role_arn" { type = string }
variable "cilium_role_arn" { type = string }
variable "eks_nodes_sg_id" { type = string }
variable "vpc_id" { type = string }
variable "aws_region" { type = string }