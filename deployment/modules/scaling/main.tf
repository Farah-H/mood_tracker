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

# # cloudwatch
# resource "aws_cloudwatch_metric_alarm" "mood_app_requests" {
#   alarm_name                = "mood-app-requests-alarm"
#   comparison_operator       = "GreaterThanUpperThreshold"
#   evaluation_periods        = "2"
#   threshold_metric_id       = "ad1"

#   metric_query {
#     id = "m1"

#     metric {
#       metric_name = "RequestCount"
#       namespace   = "AWS/ApplicationELB"
#       period      = "300"
#       stat        = "Sum"

#       dimensions = {
#         LoadBalancer = aws_elb.mood_elb.id
#       }
#     }
#   }

#   metric_query {
#     id = "ad1"
#     label = "RequestCount (expected)"
#     return_data = true
#     expression = "ANOMALY_DETECTION_BAND(m1, 2)"
#   }

#   alarm_description= "Too many incoming requests"
#   tags = {
#     Name = "mood-cloudwatch-requests-alarm"
#   }
# }

# autoscaling using EC2
