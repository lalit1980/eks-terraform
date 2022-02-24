locals {
    ubuntu_ami = "ami-055d15d9cfddf7bd3"
    route53_hosted_zone_id= "Z07706493KO3C0SVC2CCK"

    traffic_dist_map = {
        blue = {
        blue  = 100
        green = 0
        }
        blue-90 = {
        blue  = 90
        green = 10
        }
        split = {
        blue  = 50
        green = 50
        }
        green-90 = {
        blue  = 10
        green = 90
        }
        green = {
        blue  = 0
        green = 100
        }
    }
}

# Application Load Balancer
# At least two subnets in two different Availability Zones must be specified
# aws_lb: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "app" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
  security_groups = [aws_security_group.web.id]
}

# Load Balancer Listener
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    # target_group_arn = aws_lb_target_group.blue.arn
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 0)
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 100)
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
resource "aws_route53_record" "alias_route53_record" {
  zone_id = local.route53_hosted_zone_id # Replace with your zone ID
  name    = "blue-green.golalit.com" # Replace with your name/domain/subdomain
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}