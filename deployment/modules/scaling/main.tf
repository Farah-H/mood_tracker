# ELB
resource "aws_elb" "mood_app_elb" {
    name = "app_elb"
    security_groups = [aws_security_group.elb_sg.id]


    # could have other public subnets across different availability zones and cross load balancing would allow balancing across them
    # so if one zone is down, can balance across additional zones
    subnets = [aws_subnet.public_subnet.id]

    cross_zone_load_balancing = true 

    health_check {
        healthy_threshhold = 2
        unhealthy_threshhold = 2
        timeout = 3
        interval = 30
        targets = ["HTTP:80/", "HTTPS:443/"]
    }

    listener {
        lb_port = [80, 443]
        lb_protocol = ["http", "https"]
        instance_port = [80, 443]
        instance_protocol = ["http", "https"]
    }
}
# autoscaling using EC2
# cloudwatch here too 