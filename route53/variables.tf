variable "vpc_id"             { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "egress_cidrs" {
  description = "Where the resolver is allowed to send DNS (TCP/UDP 53). Tighten to on-prem IPs if known."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "forward_target_ips" {
  type        = list(string)
  default     = ["10.0.3.161", "10.0.4.213"]
  description = "DNS servers to forward to"
}