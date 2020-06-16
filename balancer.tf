resource "aws_elb" "elb" {
   name = "balancer"
   security_groups = ["${aws_security_group.web_security_group.id}"]
   subnets = ["${aws_subnet.myvpc_public_subnet.id}"]
   health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
   listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 80
    instance_protocol = "http"
  }
    instances = aws_instance.my_web_instance[*].id
}




/*resource "aws_security_group" "elbs" {
  name        = "terraform_elb_sg"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.myvpc.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

   


resource "aws_ami_from_instance" "golden" {
  name = "ami-web"
  source_instance_id = aws_instance.my_web_instance[0].id
}


resource "aws_launch_configuration" "launch_configuration" {
  image_id = "${aws_ami_from_instance.golden.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.web_security_group.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"

  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_cluster" {
  launch_configuration = "${aws_launch_configuration.launch_configuration.id}"
  vpc_zone_identifier = ["${aws_subnet.myvpc_public_subnet2.id}"]
  min_size = 2
  max_size = 4
  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "my_web"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}


*/

