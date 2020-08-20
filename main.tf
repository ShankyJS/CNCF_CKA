provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

module "rancherNode" {
  source = "./modules/rancherNode"
  ssh_key_name = "${var.ssh_key_name}"
}
# module "networking" {
#   source = "./modules/networking"
#   domain_name = "${var.domain_name}"
#   record_name = "${var.record_name}"
#   rancherNode_ipv4 = "${module.rancherNode.rancherNode_ipv4}"
# }