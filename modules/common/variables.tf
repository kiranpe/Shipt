#Security Group
################

variable "ports" {
  type        = list(number)
  description = "List of ports"
  default     = [22, 80, 443]
}
