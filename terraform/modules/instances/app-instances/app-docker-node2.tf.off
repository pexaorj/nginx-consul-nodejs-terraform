resource "aws_instance" "nodejs_2" {
  ami = "ami-d15a75c7"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${var.sg_nodejs_id}", "${var.sg_consul_id}"]
  subnet_id = "${var.subnet_app_c}"
  key_name = "${var.debug_key_pair_id}"
  user_data = "${data.template_file.nodejs_install2.rendered}"

  tags {
    Name = "nodejs_2"
  }
}

data "template_file" "nodejs_install2" {
  template = "${file("modules/instances/app-instances/files/nodejs_install.sh")}"
}

resource "aws_route53_record" "nodejs_2" {
   zone_id = "${var.rt53_zone_id}"
   name = "node-2"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.nodejs_2.private_ip}"]
}
