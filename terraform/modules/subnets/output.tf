output "subnet_app_a_id" {
	value = "${aws_subnet.app_a.id}"
} 
output "subnet_app_c_id" {
        value = "${aws_subnet.app_c.id}"
} 
output "subnet_dmz_a_id" {
        value = "${aws_subnet.dmz_a.id}"
} 
output "subnet_dmz_c_id" {
        value = "${aws_subnet.dmz_c.id}"
}



output "subnet_app_a_net_id" {
	value = "${aws_subnet.app_a.cidr_block}"
} 
output "subnet_app_c_net_id" {
        value = "${aws_subnet.app_c.cidr_block}"
} 
output "subnet_dmz_a_net_id" {
        value = "${aws_subnet.dmz_a.cidr_block}"
} 
output "subnet_dmz_c_net_id" {
        value = "${aws_subnet.dmz_c.cidr_block}"
}

