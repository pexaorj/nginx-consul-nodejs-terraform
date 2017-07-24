resource "aws_instance" "nodejs_1" {
  ami = "ami-d15a75c7"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${var.sg_nodejs_id}", "${var.sg_consul_id}"]
  subnet_id = "${var.subnet_app_a}"
  key_name = "${var.debug_key_pair_id}"
  user_data = "${data.template_file.nodejs_install.rendered}"

  tags {
    Name = "nodejs_1"
  }
}

data "template_file" "nodejs_install" {
  template = "${file("modules/instances/app-instances/files/nodejs_install.sh")}"
}

resource "aws_route53_record" "nodejs_1" {
   zone_id = "${var.rt53_zone_id}"
   name = "node-1"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.nodejs_1.private_ip}"]
}
