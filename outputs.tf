output "manager" {
  value = "${aws_instance.manager.public_ip}"
}

output "nodes" {
  value = "${aws_instance.node.*.public_ip}"
}
