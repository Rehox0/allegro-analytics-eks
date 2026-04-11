variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "ami_id" { type = string }
variable "user_data_script" { type = string }
variable "instance_profile_name" { type = string }
variable "management_sg_id" { type = string }