# public security groups ==============================================================
resource "aws_security_group" "sg_public_service" {
 name = "sg_${var.customer}_${var.project}-${var.platform}_public_service"
 description = "allow http inbound traffic"
 vpc_id = "${aws_vpc.vpc33.id}"
 
 tags {
   Name = "sg_${var.customer}_${var.project}-${var.platform}_public_service"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
 
 ingress {
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = [
     "0.0.0.0/0"
   ]
 }
}
 
# front security groups ==============================================================
resource "aws_security_group" "sg_front_service" {
 name = "sg_${var.customer}_${var.project}-${var.platform}_front_service"
 description = "allow http inbound traffic from the public service sg; all tcp inside the SG"
 vpc_id = "${aws_vpc.vpc33.id}"
 tags {
 Name = "sg_${var.customer}_${var.project}-${var.platform}_front_service"
 Customer = "${var.customer}"
 Platform = "${var.platform}"
 }
 
 ingress {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   security_groups = [
     "${aws_security_group.sg_public_service.id}"
   ]
 }
 
 ingress {
   from_port = 0
   to_port = 65535
   protocol = "tcp"
   self = "true"
 }
}
resource "aws_security_group" "sg_front_infra" {
 name = "sg_${var.customer}_${var.project}-${var.platform}_front_infra"
 description = "standard ssh &amp; monitoring"
 vpc_id = "${aws_vpc.vpc33.id}"
 
 tags {
   Name = "sg_${var.customer}_${var.project}-${var.platform}_front_infra"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
 
 ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = [
     "**************/32",
     "**************/32"
   ]
 }
 
 ingress {
   from_port = -1
   to_port = -1
   protocol = "icmp"
   cidr_blocks = [
     "130.193.24.141/32"
   ]
 }
}
 
# back security groups ==============================================================
resource "aws_security_group" "sg_back_service" {
 name = "sg_${var.customer}_${var.project}-${var.platform}_back_service"
 description = "allow inbound traffic from the front sg"
 vpc_id = "${aws_vpc.vpc33.id}"
 
 tags {
   Name = "sg_${var.customer}_${var.project}-${var.platform}_back_service"
   Customer = "${var.customer}"
   Platform = "${var.platform}"
 }
 
 ingress {
   from_port = 3306
   to_port = 3306
   protocol = "tcp"
   security_groups = [
     "${aws_security_group.sg_front_service.id}"
   ]
 }
}