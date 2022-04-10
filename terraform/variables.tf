variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "token" {
  type = string
}

variable "service_account_id" {
  type = string
}

variable "functions" {
  type = list(any)
}