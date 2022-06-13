# ELB
resource "aws_elb" "mood_elb" {
  instances              = [var.app_instance_id]
  subnets                = [var.public_subnet_id]
  desync_mitigation_mode = "defensive"

  listener {
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:5000/"
    interval            = 30
  }

  tags = {
    Name = "mood-elb"
  }
}
# autoscaling using EC2 ? 
# cloudwatch here too 
