output "db_host" {
  value = aws_db_instance.mood_db.address
}

output "db_username" {
  value     = aws_db_instance.mood_db.username
  sensitive = true
}

output "db_password" {
  value     = aws_db_instance.mood_db.password
  sensitive = true
}
