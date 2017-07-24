resource "aws_vpc" "main-vpc" {
    cidr_block = "${var.cidrblockvpc}"
    enable_dns_support = true
    enable_dns_hostnames = true 
    tags {
        Name = "${var.project}-vpc"
    }
}
resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dhcp-options.id}"
}
resource "aws_main_route_table_association" "route_default" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    route_table_id = "${var.mainvpcassoc_routetabledefaultaid}"
}
