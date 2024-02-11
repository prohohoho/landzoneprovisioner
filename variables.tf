variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "environment_short_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "company_short_name" {
  type = string
}
variable "location_short_name" {
  type = string
}
variable "location" {
  type = string
}
variable "isdemo" {
  type = bool
  default = false
}
variable "backup_type" {
  type = string
  validation {
    condition     = contains(["NoBackups", "AzureBackups", "Acronis" , "Veeam"], var.backup_type)
    error_message = "Invalid value. Acceptable values are: [NoBackups,AzureBackups,Acronis,Veeam]."
  }
}
