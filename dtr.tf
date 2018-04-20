resource "aws_instance" "dtr" {
  ami           = "${data.aws_ami.ubuntu.image_id}"
  instance_type = "t2.medium"
  subnet_id     = "${aws_subnet.ucp.id}"
  key_name      = "${var.keyname}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.dtr.id}",
    "${aws_vpc.ee.default_security_group_id}",
  ]

  tags {
    Name = "DTR"
  }

  provisioner "file" {
    source      = "scripts/setup-vm.sh"
    destination = "/tmp/setup-vm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "export DOCKER_EE_SUBSCRIPTION_ID=${var.docker_ee_subscription_id}",
      "export DOCKER_EE_CHANNEL=${var.docker_ee_channel}",
      "chmod +x /tmp/setup-vm.sh",
      "/tmp/setup-vm.sh ucpnode",
    ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
  }
}

resource "aws_elb_attachment" "dtr" {
  elb      = "${aws_elb.dtr.id}"
  instance = "${aws_instance.dtr.id}"
}

resource "aws_security_group" "dtr" {
  name   = "dtr"
  vpc_id = "${aws_vpc.ee.id}"

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lb-dtr.id}"]
  }
}
