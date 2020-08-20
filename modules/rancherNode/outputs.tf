# Using this output as a variable
output "masterNode_ipv4" {
  value = "${digitalocean_droplet.masterNode.ipv4_address}"	
}

output "workerNode_ipv4" {
  value = "${digitalocean_droplet.workerNode.ipv4_address}"	
}