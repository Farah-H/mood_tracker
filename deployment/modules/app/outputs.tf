output "app_instance" {
  value = aws_instance.mood_app.public_dns
}
