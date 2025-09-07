variable "vpc_id"             { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "admin_ip_cidr" {
  type        = string
  default     = "73.60.225.63/32"
}
variable "key_name" {
  type    = string
  default = "jmccoytest"
}
variable "ssm_instance_profile_name" {
  type    = string
  default = "jmccoy-ssm-role"
}
variable "private_subnet_id_a" { type = string }  
variable "private_subnet_id_b" { type = string }  