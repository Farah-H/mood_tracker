resource "aws_subnet" "public_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.20.0/24"
    map_public_ip_on_launch = true 

    tags = {
        Name = "mood_public_subnet"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }

    tags = {
        Name = "mood_public_rt"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_network_acl" "public_nacl" {
    vpc_id = var.vpc_id
    subnet_ids = [aws_subnet.public_subnet.id]

    tags = {
        Name = "mood_public_nacl"
    }

    ingress {
        rule_no = 100
        action = "allow"
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    ingress {
        rule_no = 200
        action = "allow"
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    ingress {
        rule_no = 300
        action = "allow"
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    ingress {
        rule_no = 400
        action = "allow"
        from_port = 22
        to_port = 22
        cidr_block = var.my_ip
        protocol = "tcp"
    }

    egress {
        rule_no = 100
        action = "allow"
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    egress {
        rule_no = 200
        action = "allow"
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    egress {
        rule_no = 300
        action = "allow"
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
    }

    egress {
        rule_no = 400
        action = "allow"
        from_port = 22
        to_port = 22
        cidr_block = var.my_ip
        protocol = "tcp"
    }
} 

resource "aws_subnet" "private_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.10.0/24"

    tags = {
        Name = "mood_private_subnet"
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = var.vpc_id

    tags = {
        Name = "mood_private_rt"
    }
}

resource "aws_route_table_association" "private_subnet_association" {
    subnet_id= aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_network_acl" "private_nacl" {
    vpc_id = var.vpc_id
    subnet_ids = [aws_subnet.private_subnet.id]

    tags = {
        Name = "mood_private_nacl"
    }


    ingress {
        rule_no = 100
        action = "allow"
        from_port = 3306
        to_port = 3306
        cidr_block = "10.0.0.0/16"
        protocol = "tcp"
    }

    ingress {
        rule_no = 200
        action = "allow"
        from_port = 22
        to_port = 22
        cidr_block = var.my_ip
        protocol = "tcp"
    }


    # could allow all out, but better to define explicitly at NACL level
    egress {
        rule_no = 100
        action = "allow"
        from_port = 3306
        to_port = 3306
        cidr_block = "10.0.0.0/16"
        protocol = "tcp"
    }

    egress {
        rule_no = 200
        action = "allow"
        from_port = 22
        to_port = 22
        cidr_block = var.my_ip
        protocol = "tcp"
    }

} 