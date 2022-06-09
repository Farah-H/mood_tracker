output "db_host" {
  value = aws_db_instance.mood_db.address
}

output "db_username" {
  value = sensitive(aws_db_instance.mood_db.username)
}

output "db_password" {
  value = sensitive(aws_db_instance.mood_db.password)
}
