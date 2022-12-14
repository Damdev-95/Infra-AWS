locals {
  availability_zones = split(",", var.availability_zones)
}

resource "aws_elb" "web-elb" {
  name = "PythonAPP-elb"
  security_groups = [aws_security_group.elb-sg.id]
  availability_zones = local.availability_zones

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
    target              = "HTTP:80/"
    interval            = 30
  }
}

resource "aws_autoscaling_group" "web-asg" {
  availability_zones   = local.availability_zones
  name                 = "PythonAPP-asg"
  max_size             = var.asg_max
  min_size             = var.asg_min
  desired_capacity     = var.asg_desired
  force_delete         = true
  launch_configuration = aws_launch_configuration.web-lc.name
  load_balancers       = [aws_elb.web-elb.name]

  #vpc_zone_identifier = ["${split(",", var.availability_zones)}"]
  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "web-lc" {
  name          = "PythonAPP-lc"
  image_id      = var.ami[var.aws_region]
  instance_type = var.instance_type


  security_groups = [aws_security_group.webserver-sg.id]
  user_data       = file("userdata.sh")
  key_name        = var.key_name
}