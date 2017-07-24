resource "aws_security_group" "sg_nodejs" {
        name = "tf_df_infra_nodejs_and_ssh"
        description = "Permite trafego ssh do bastion e http app"
        vpc_id = "${var.vpcid}"

  ingress {
    from_port   = 3000
    to_port     = 3032
    protocol    = "6"
    cidr_blocks = ["${var.subnet_app_net_a}", "${var.subnet_app_net_c}", "${var.subnet_dmz_net_a}", "${var.subnet_dmz_net_c}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["${var.subnet_app_net_a}", "${var.subnet_app_net_c}", "${var.subnet_dmz_net_a}", "${var.subnet_dmz_net_c}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
        tags {
                Name = "tf_df_infra_nodejs"
        }
}
