variable "db_username" {
  description = "export TF_VAR_db_username=<your-desired-master-username>"
}

variable "db_password" {
  description = "export TF_VAR_db_password=<your-desired-db-password>"
}

variable "ssh_key_name" {
  description = "SSH .pem key name"
}

variable "ssh_key_path" {
  description = "SSH key path"
}