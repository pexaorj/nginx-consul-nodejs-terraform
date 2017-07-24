output "route_default_a_id" {
	value = "${aws_route_table.main_route_table_default_a.id}"
}
output "route_default_c_id" {
        value = "${aws_route_table.main_route_table_default_c.id}"
}
output "route_dmz_id" {
        value = "${aws_route_table.main_route_table_dmz.id}"
}
