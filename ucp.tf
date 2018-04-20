resource "aws_instance" "manager" {
  ami           = "${data.aws_ami.ubuntu.image_id}"
  instance_type = "t2.medium"
  subnet_id     = "${aws_subnet.ucp.id}"
  key_name      = "${var.keyname}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.manager.id}",
    "${aws_vpc.ee.default_security_group_id}"
  ]

  tags {
    Name = "UCP manager"
  }

  provisioner "file" {
    source      = "scripts/setup-vm.sh"
    destination = "/tmp/setup-vm.sh"
  }

  provisioner "file" {
    source      = "docker_subscription.lic"
    destination = "/tmp/docker_subscription.lic"
  }

  provisioner "remote-exec" {
    inline = [
      "export DOCKER_EE_SUBSCRIPTION_ID=${var.docker_ee_subscription_id}",
      "export DOCKER_EE_CHANNEL=${var.docker_ee_channel}",
      "export UCP_ADMIN_USER=admin",
      "export UCP_ADMIN_PASSWORD=${var.ucp_admin_password}",
      "export UCP_HOSTNAMES=${aws_elb.manager.dns_name}",
      "chmod +x /tmp/setup-vm.sh",
      "/tmp/setup-vm.sh ucpmanager",
    ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
  }
}

resource "aws_elb_attachment" "ucp" {
  elb      = "${aws_elb.manager.id}"
  instance = "${aws_instance.manager.id}"
}

resource "aws_security_group" "manager" {
  name   = "manager"
  vpc_id = "${aws_vpc.ee.id}"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${aws_security_group.lb-manager.id}"]
  }
  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    security_groups = ["${aws_security_group.lb-manager.id}"]
  }
}
