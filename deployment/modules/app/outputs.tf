output "app_instance_dns" {
  value = aws_instance.mood_app.public_dns
}
output "app_instance_id" {
  value = aws_instance.mood_app.id
}