output "manager-url" {
  value = "https://${aws_elb.manager.dns_name}"
}

output "manager" {
  value = "${aws_instance.manager.public_ip}"
}

output "nodes" {
  value = "${aws_instance.node.*.public_ip}"
}

