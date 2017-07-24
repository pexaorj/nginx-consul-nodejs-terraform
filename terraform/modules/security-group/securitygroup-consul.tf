resource "aws_security_group" "sg_consul" {
        name = "tf_df_infra_consul"
        description = "Permite trafego para o servico consul"
        vpc_id = "${var.vpcid}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["${var.subnet_app_net_a}", "${var.subnet_app_net_c}", "${var.subnet_dmz_net_a}", "${var.subnet_dmz_net_c}"]
  }
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "6"
    cidr_blocks = ["${var.subnet_app_net_a}", "${var.subnet_app_net_c}", "${var.subnet_dmz_net_a}", "${var.subnet_dmz_net_c}"]
  }
  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "17"
    cidr_blocks = ["${var.subnet_app_net_a}", "${var.subnet_app_net_c}", "${var.subnet_dmz_net_a}", "${var.subnet_dmz_net_c}"]
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "17"
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
                Name = "tf_df_infra_consul"
        }
}
