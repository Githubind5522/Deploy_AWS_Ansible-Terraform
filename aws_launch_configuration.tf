resource "aws_launch_configuration" "packer_lc" {
  image_id      = "${data.aws_ami.packer_ami.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.packer_websg.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
