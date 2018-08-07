# VPC ==============================================================
resource "aws_vpc" "vpc33" {
 cidr_block = "10.${var.my_cidr_block}.0.0/16"
 tags {
   Name = "vpc_${var.customer}_${var.project}-${var.platform}"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
# front subnets ==============================================================
resource "aws_subnet" "front-a" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.0.0/23"
 availability_zone = "${var.region}a"
 map_public_ip_on_launch = true
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_front_a"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
resource "aws_subnet" "front-b" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.2.0/23"
 availability_zone = "${var.region}b"
 map_public_ip_on_launch = true
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_front_b"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
resource "aws_subnet" "front-c" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.4.0/23"
 availability_zone = "${var.region}c"
 map_public_ip_on_launch = true
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_front_c"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
# back subnets ==============================================================
resource "aws_subnet" "back-a" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.6.0/23"
 availability_zone = "${var.region}a"
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_back_a"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
resource "aws_subnet" "back-b" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.8.0/23"
 availability_zone = "${var.region}b"
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_back_b"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
resource "aws_subnet" "back-c" {
 vpc_id = "${aws_vpc.vpc33.id}"
 cidr_block = "10.${var.my_cidr_block}.10.0/23"
 availability_zone = "${var.region}c"
 tags {
   Name = "subnet_${var.customer}_${var.project}-${var.platform}_back_c"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
}
 
# routing ==============================================================
resource "aws_internet_gateway" "gw-to-internet33" {
 vpc_id = "${aws_vpc.vpc33.id}"
}
 
resource "aws_route_table" "route-to-gw33" {
 vpc_id = "${aws_vpc.vpc33.id}"
 route {
 cidr_block = "0.0.0.0/0"
   gateway_id = "${aws_internet_gateway.gw-to-internet33.id}"
 }
}
 
resource "aws_route_table_association" "front-a" {
 subnet_id = "${aws_subnet.front-a.id}"
 route_table_id = "${aws_route_table.route-to-gw33.id}"
}
 
resource "aws_route_table_association" "front-b" {
 subnet_id = "${aws_subnet.front-b.id}"
 route_table_id = "${aws_route_table.route-to-gw33.id}"
}
 
resource "aws_route_table_association" "front-c" {
 subnet_id = "${aws_subnet.front-c.id}"
 route_table_id = "${aws_route_table.route-to-gw33.id}"
}