resource "aws_route_table" "main_route_table_dmz" {

vpc_id = "${var.vpcid}"

/*Rota para internet*/
route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main_internet_gw.id}"
}

route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main_internet_gw.id}"
}

tags {
        Name = "${var.project}-route-dmz"
}


}

