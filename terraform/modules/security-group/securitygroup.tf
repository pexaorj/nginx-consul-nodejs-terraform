resource "aws_security_group" "tf_df_infra_nat" {
        name = "tf_df_infra_nat"
        description = "Permite trafego da rede interna"
        vpc_id = "${var.vpcid}"
        ingress {
                from_port = 0
                to_port = 0
                protocol = "-1" /*-1 ALL Traffic*/
                cidr_blocks = ["${var.vpccidr_block}"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1" /*-1 ALL Traffic*/
                cidr_blocks = ["0.0.0.0/0"]
        }

        tags {
                Name = "tf_df_infra_nat"
                Description = "Terraform default infra NAT"
             }
}

resource "aws_security_group" "tf_df_only_for_test" {
        name = "tf_df_all_only_for_test"
        description = "Permite todo o trafego"
        vpc_id = "${var.vpcid}"
	ingress {
    		from_port   = 0
  	  	to_port     = 65535
    		protocol    = "tcp"
    		cidr_blocks = ["0.0.0.0/0"]
  	}

        tags {
                Name = "tf_df_only_for_test"
                Description = "Terraform allow all just for test"
             }
}
