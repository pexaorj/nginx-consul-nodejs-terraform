output vpcid {
	value = "${aws_vpc.main-vpc.id}"
}
output "base_block_a" {
        value =  "${element(split(".","${var.cidrblockvpc}"), 0)}.${element(split(".","${var.cidrblockvpc}"),1)}.${element(split(".", "${var.cidrblockvpc}"),2)}.0/24"
}
output "base_block_c" {
        value =  "${element(split(".","${var.cidrblockvpc}"), 0)}.${element(split(".","${var.cidrblockvpc}"),1)}.${element(split(".", "${var.cidrblockvpc}"),2)+1}.0/24"
}
output "rt53_zone_id" {
	value = "${aws_route53_zone.main.zone_id}"
}
output "rt53_name_servers" {
	value = "${aws_route53_zone.main.name_servers}"
}
