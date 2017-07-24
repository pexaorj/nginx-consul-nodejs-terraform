resource "aws_internet_gateway" "main_internet_gw" {
    vpc_id = "${var.vpcid}"
    tags {
        Name = "${var.project}-main-internet-gateway"
    }
}
