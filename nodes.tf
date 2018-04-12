resource "aws_instance" "node" {
  ami           = "${data.aws_ami.ubuntu.image_id}"
  instance_type = "t2.medium"
  subnet_id     = "${aws_subnet.ucp.id}"
  key_name      = "${var.keyname}"
  count         = 5

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_vpc.ee.default_security_group_id}",
  ]

  tags {
    Name = "UCP node"
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
