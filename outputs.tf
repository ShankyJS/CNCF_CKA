# Using this output as a variable
output "masterNode_ipv4" {
  value = module.nodes.masterNode_ipv4
}

output "workerNode_ipv4" {
  value = module.nodes.workerNode_ipv4
}