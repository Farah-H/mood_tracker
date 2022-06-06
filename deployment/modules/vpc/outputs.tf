output "vpc_id" {
    value = aws_vpc.mood_vpc.id
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}