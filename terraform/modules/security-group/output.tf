output "sg_nat_id" {
	value = "${aws_security_group.tf_df_infra_nat.id}"
}
output "sg_nodejs_id" {
	value = "${aws_security_group.sg_nodejs.id}"
}
output "sg_nginx_id" {
	value = "${aws_security_group.sg_nginx.id}"
}
output "sg_ssh_id" {
	value = "${aws_security_group.sg_ssh.id}"
}
output "sg_consul_id" {
	value = "${aws_security_group.sg_consul.id}"
}
