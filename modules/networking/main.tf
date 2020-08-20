# variable "domain_name" {

# }

# variable "record_name" {

# }

# variable "rancherNode_ipv4" {
  
# }

# # Adding a Record to use it with the Rancher 
# resource "digitalocean_record" "rancherDomain" {
#   domain      = "${var.domain_name}"
#   name        = "${var.record_name}"
#   # value       = "${digitalocean_droplet.rancherNode.ipv4_address}"
#   value       = "${var.rancherNode_ipv4}"
#   type        = "A"
#   ttl         = "30"
# }
