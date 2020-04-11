# Create a new load balancer
resource "aws_elb" "terra-elb" {
  name = "terra-elb"
  availability_zones = ["${var.azs}"]
  subnets = ["${aws_subnet.public.*.id}"]
  security_groups = ["${aws_security_group.packer_websg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "terraform-elb-apache"
  }
}