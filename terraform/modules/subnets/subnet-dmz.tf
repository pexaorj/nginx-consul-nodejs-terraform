resource "aws_subnet" "dmz_a" {
    vpc_id = "${var.vpcid}"
    availability_zone = "${var.regiao}a"
    cidr_block = "${(cidrsubnet(var.base_block_a,4,0))}"
    tags {
        Name = "${var.project}-dmz-a"
    }
}
resource "aws_route_table_association" "dmz_a" {
    subnet_id = "${aws_subnet.dmz_a.id}"
    route_table_id = "${var.routetable_dmz_id}"
}

resource "aws_subnet" "dmz_c" {
    vpc_id = "${var.vpcid}"
    availability_zone = "${var.regiao}c"
    cidr_block = "${(cidrsubnet(var.base_block_c,4,0))}"
    tags {
        Name = "${var.project}-dmz-c"
    }
}
resource "aws_route_table_association" "dmz_c" {
    subnet_id = "${aws_subnet.dmz_c.id}"
    route_table_id = "${var.routetable_dmz_id}"
}
