resource "aws_security_group" "sg_ssh" {
        name = "tf_df_infra_ssh"
        description = "Permite trafego ssh"
        vpc_id = "${var.vpcid}"
        ingress {
                from_port = 22
                to_port = 22
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
                Name = "tf_df_infra_ssh"
        }
}
