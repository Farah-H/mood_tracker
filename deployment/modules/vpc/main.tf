# vpc
resource "aws_vpc" "mood_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames

    tags = {
        Name = "mood_vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.mood_vpc.id

    tags = {
        Name = "mood_igw"
    }
}

resource "aws_route_table" "mood_rt" {
    vpc_id = aws_vpc.mood_vpc.id

    dynamic "route" {
        for_each = var.route
        content {
            cidr_block     = route.value.cidr_block
            gateway_id     = route.value.gateway_id
            instance_id    = route.value.instance_id
            nat_gateway_id = route.value.nat_gateway_id
        }
    }
    
    tags = {
        Name = "mood_rt"
    }
}

resource "aws_route_table_association" "mood_rt_association" {
    count          = length(var.subnet_ids)

    subnet_id      = element(var.subnet_ids, count.index)
    route_table_id = aws_route_table.mood_rt.id

    tags = {
        Name = "mood_rt_association"
    }
}
