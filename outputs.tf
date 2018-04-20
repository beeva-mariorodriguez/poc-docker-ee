output "manager-url" {
  value = "https://${aws_elb.manager.dns_name}"
}

output "manager" {
  value = "${aws_instance.manager.public_ip}"
}

output "dtr-url" {
  value = "https://${aws_elb.dtr.dns_name}"
}

output "dtr" {
  value = "${aws_instance.dtr.public_ip}"
}

output "dtr-node" {
  value = "${aws_instance.dtr.private_dns}"
}

output "nodes" {
  value = "${aws_instance.node.*.public_ip}"
}
