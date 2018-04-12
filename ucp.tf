resource "aws_instance" "manager" {
  ami           = "${data.aws_ami.ubuntu.image_id}"
  instance_type = "t2.medium"
  subnet_id     = "${aws_subnet.ucp.id}"
  key_name      = "${var.keyname}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_vpc.ee.default_security_group_id}",
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
      "export UCP_HOSTNAMES=${var.ucp_hostnames}",
      "chmod +x /tmp/setup-vm.sh",
      "/tmp/setup-vm.sh ucpmanager",
    ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
  }
}
