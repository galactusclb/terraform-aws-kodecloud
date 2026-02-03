variable "db_username" {
  description = "DB username"
  type =  string
  sensitive = true
}

variable "db_password" {
  description = "DB password"
  type      = string
  sensitive = true
}

variable "db_host" {
  type = string
}

variable "db_name" {
  type = string
}