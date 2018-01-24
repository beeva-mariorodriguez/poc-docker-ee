resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = "${aws_vpc.ee.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
