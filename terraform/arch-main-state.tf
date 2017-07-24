provider "aws" {
        region = "us-east-1"
        shared_credentials_file = "/root/.aws/credentials"
        profile                 = "default"
}

terraform {
    backend "s3" {
    bucket = "terraform-chaordic"
    key    = "arch-state/terraform.tfstate"
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials"
    profile                 = "default"
  }
}

module "env" {
    source = "./modules/env"
    project = "${var.project-name}"
}

module "eip" {
    source = "./modules/eip"
}

module "vpc" {
    source = "./modules/vpc"
    project = "${var.project-name}"
    cidrblockvpc = "${module.env.cidrblockip}"
    mainvpcassoc_routetabledefaultaid = "${module.routes.route_default_a_id}"
    region = "${var.region}"
    dnszone = "${var.dnszone}"
}
module "routes" {
    source = "./modules/routes"
    project = "${var.project-name}"
    vpcid = "${module.vpc.vpcid}"
    nat-aid = "${module.arch-instances.instance_nat_a_id}"
#    nat-aid = "i-09eb4b93f5d248261"
#    nat-cid = "${module.arch-instances.instance_nat_c_id}"
    region = "${var.region}"
}
module "subnets" {
    source = "./modules/subnets"
    vpcid = "${module.vpc.vpcid}"
    regiao = "${var.region}"
    project = "${var.project-name}"
    cidrblockvpc = "${module.env.cidrblockip}"
    base_block_a = "${module.vpc.base_block_a}"
    base_block_c = "${module.vpc.base_block_c}"
    routetable_dmz_id = "${module.routes.route_dmz_id}"
    routetable_defaulta_id = "${module.routes.route_default_a_id}"
    routetable_defaultc_id = "${module.routes.route_default_c_id}"
}
module "securitygroup" {
    source = "./modules/security-group"
    vpcid = "${module.vpc.vpcid}"
    vpccidr_block = "${module.env.cidrblockip}"
    subnet_app_net_a = "${module.subnets.subnet_app_a_net_id}"
    subnet_app_net_c = "${module.subnets.subnet_app_c_net_id}"
    subnet_dmz_net_a = "${module.subnets.subnet_dmz_a_net_id}"
    subnet_dmz_net_c = "${module.subnets.subnet_dmz_c_net_id}"
}
module "arch-instances" {
    source = "./modules/instances/arch-instances"
    project = "${var.project-name}"
    sg_nat_id = "${module.securitygroup.sg_nat_id}"
    sg_nginx_id = "${module.securitygroup.sg_nginx_id}"
    sg_ssh_id = "${module.securitygroup.sg_ssh_id}"
    sg_consul_id = "${module.securitygroup.sg_consul_id}"
    subnet_dmz_a = "${module.subnets.subnet_dmz_a_id}"
    subnet_dmz_c = "${module.subnets.subnet_dmz_c_id}"
    eip_nat_a_id = "${module.eip.eip_nat_a_id}"
#    eip_nat_a_id = "0.0.0.0"
    eip_nginx_a_id = "${module.eip.eip_nginx_a_id}"
    cidrblockvpc = "${module.env.cidrblockip}"
    rt53_zone_id = "${module.vpc.rt53_zone_id}"
    dnszone_name = "${var.dnszone}"
    debug_key_pair_id = "${aws_key_pair.debug.key_name}"
}
module "app-instances" {
    source = "./modules/instances/app-instances"
    project = "${var.project-name}"
    sg_nodejs_id = "${module.securitygroup.sg_nodejs_id}"
    sg_consul_id = "${module.securitygroup.sg_consul_id}"
    subnet_app_a = "${module.subnets.subnet_app_a_id}"
    subnet_app_c = "${module.subnets.subnet_app_c_id}"
    cidrblockvpc = "${module.env.cidrblockip}"
    rt53_zone_id = "${module.vpc.rt53_zone_id}"
    dnszone_name = "${var.dnszone}"
    debug_key_pair_id = "${aws_key_pair.debug.key_name}"
}
