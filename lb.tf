resource "aws_elb" "manager" {
  name            = "manager"
  security_groups = ["${aws_security_group.lb-manager.id}"]
  subnets         = ["${aws_subnet.ucp.id}"]

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }
}

resource "aws_security_group" "lb-manager" {
  name   = "lb-manager"
  vpc_id = "${aws_vpc.ee.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "dtr" {
  name            = "dtr"
  security_groups = ["${aws_security_group.lb-dtr.id}"]
  subnets         = ["${aws_subnet.ucp.id}"]

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }
}

resource "aws_security_group" "lb-dtr" {
  name   = "lb-dtr"
  vpc_id = "${aws_vpc.ee.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
