variable "service_name" {
  type        = string
  description = "The name of the service."
}

variable "notification_channels" {
  type = string
  description = "The channels that will receive notification if an incident occours (e.g., @example@gmail.com.br)"
  default = ""
}
variable "error_critical_threshold" {
  type = number
  description = "The value of the critical threshold for the error rate monitor"
  default = 5
}

variable "error_recovery_threshold" {
  type = number
  description = "The value of the recovery threshold for the error rate monitor"
  default = 2
}

variable "request_critical_threshold" {
  type = number
  description = "The value of the critical threshold for the request monitor"
  default = 25  
}

variable "request_recovery_threshold" {
  type = number
  description = "The value of the recovery threshold for the request monitor"
  default = 12
}

variable "environment" {
  type        = string
  description = "The environment in which the service will run (e.g., devhml, prd)."
}

