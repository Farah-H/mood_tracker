output "elb_id" {
  value = aws_elb.mood_elb.id
}

output "elb_dns" {
  value = aws_elb.mood_elb.dns_name
}