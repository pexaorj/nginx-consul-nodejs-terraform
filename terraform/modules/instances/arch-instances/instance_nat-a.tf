resource "aws_instance" "nat_a" {
  ami = "ami-e975cbff"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${var.sg_nat_id}"]
  subnet_id = "${var.subnet_dmz_a}"
  source_dest_check = false
  associate_public_ip_address = "true"

  tags {
    Name = "nat-instance-a"
  }
}

resource "aws_eip_association" "eip_assoc_nat_a" {
  instance_id = "${aws_instance.nat_a.id}"
  allocation_id = "${var.eip_nat_a_id}"
}
