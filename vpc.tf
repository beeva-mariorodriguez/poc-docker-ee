resource "aws_vpc" "ee" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "ucp" {
  vpc_id                  = "${aws_vpc.ee.id}"
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ee.id}"
}

resource "aws_route" "r" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_vpc.ee.default_route_table_id}"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
