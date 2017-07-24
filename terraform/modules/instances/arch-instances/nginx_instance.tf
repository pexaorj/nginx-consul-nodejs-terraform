resource "aws_instance" "nginx" {
  ami = "ami-d15a75c7"
  instance_type = "t2.micro"
 # instance_type = "t2.nano"
  vpc_security_group_ids = ["${var.sg_nginx_id}", "${var.sg_ssh_id}", "${var.sg_consul_id}"]
  subnet_id = "${var.subnet_dmz_a}"
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "${var.debug_key_pair_id}"
  user_data = "${data.template_file.nginx_install.rendered}"

  tags {
    Name = "nginx-web-proxy"
  }
}

data "template_file" "nginx_install" {
  template = "${file("${path.module}/files/nginx_install.sh")}"
}

resource "aws_eip_association" "eip_assoc_nginx" {
  instance_id = "${aws_instance.nginx.id}"
  allocation_id = "${var.eip_nginx_a_id}"
}

resource "aws_route53_record" "nginx_rt53" {
   zone_id = "${var.rt53_zone_id}"
   name = "nginx"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.nginx.private_ip}"]
}

resource "aws_route53_record" "consul_rt53" {
   zone_id = "${var.rt53_zone_id}"
   name = "consul"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.nginx.private_ip}"]
}
