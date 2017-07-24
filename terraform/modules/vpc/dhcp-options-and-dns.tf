resource "aws_vpc_dhcp_options" "dhcp-options" {
    domain_name = "${var.dnszone}"
    domain_name_servers = ["AmazonProvidedDNS"]

    tags {
        Name = "${var.project}-dhcp-options"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dhcp-options.id}"
}

/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "main" {
    name = "${var.dnszone}"
    vpc_id = "${aws_vpc.main-vpc.id}"
    comment = "Managed by terraform"
}
