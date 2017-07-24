/*rota usada na AZ A envia o trafego para a instancia de NAT da AZ A*/
resource "aws_route_table" "main_route_table_default_a" {

vpc_id = "${var.vpcid}"

route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${var.nat-aid}"/*id da instancia de nat-a*/
}
tags {
        Name = "${var.project}-route-default-a"
}
}	
