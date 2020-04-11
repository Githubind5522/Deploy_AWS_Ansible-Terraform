resource "aws_autoscaling_group" "packer_asg" {
  name                 = "terraform-asg-${aws_launch_configuration.packer_lc.name}"
  launch_configuration = "${aws_launch_configuration.packer_lc.name}"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  min_size             = 2
  max_size             = 5
  load_balancers = ["${aws_elb.terra-elb.id}"]
  health_check_type = "ELB"
	lifecycle {
		create_before_destroy = true
	}
}
