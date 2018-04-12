output "managers" {
  value = "${aws_instance.manager.*.public_ip}"
}
