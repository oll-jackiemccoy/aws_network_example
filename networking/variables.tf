variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.67.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "Two CIDRs for public subnets"
  type        = list(string)
  default     = ["10.67.4.0/23", "10.67.6.0/23"]
}

variable "private_subnet_cidrs" {
  description = "Two CIDRs for private subnets"
  type        = list(string)
  default     = ["10.67.0.0/23", "10.67.2.0/23"]
}
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = { Project = "tofu-learning" }
}