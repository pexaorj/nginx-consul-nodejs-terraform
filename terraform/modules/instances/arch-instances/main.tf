variable "cidrblockvpc" {}
variable "sg_nat_id" {} 
variable "sg_nginx_id" {} 
variable "sg_ssh_id" {} 
variable "sg_consul_id" {} 
variable "subnet_dmz_a" {} 
variable "subnet_dmz_c" {} 
variable "project" {}
variable "key_name" { default = "" } 
variable "eip_nat_a_id" {}
variable "eip_nginx_a_id" {}
variable "rt53_zone_id" {}
variable "dnszone_name" {}
variable "debug_key_pair_id" {}
