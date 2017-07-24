resource "aws_security_group" "sg_nginx" {
        name = "tf_df_infra_web_nginx"
        description = "Permite trafego Web - Nginx"
        vpc_id = "${var.vpcid}"
        ingress {
                from_port = 80
                to_port = 80
                protocol = "6"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }

        tags {
                Name = "tf_df_infra_web_nginx"

        }
}
