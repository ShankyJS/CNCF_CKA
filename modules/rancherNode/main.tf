variable "ssh_key_name" {

}

resource "digitalocean_ssh_key" "ssh_key" {
  name		    = "${var.ssh_key_name}"
  public_key	= "${file("./modules/rancherNode/secrets/id_rsa.pub")}"
}

resource "digitalocean_vpc" "int1-vpc" {
  name     = "internal-vpc"
  region   = "sfo2"
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_droplet" "masterNode" {
  image       = "ubuntu-18-04-x64"
  name        = "masterNode"
  region      = "sfo2"
  size        = "s-1vcpu-1gb"
  ssh_keys    = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
  vpc_uuid    = digitalocean_vpc.int1-vpc.id
  }

resource "digitalocean_droplet" "workerNode" {
  image       = "ubuntu-18-04-x64"
  name        = "workerNode"
  region      = "sfo2"
  size        = "s-1vcpu-1gb"
  ssh_keys    = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
  vpc_uuid    = digitalocean_vpc.int1-vpc.id
  }

# resource "null_resource" "rancherConfig" {
#   depends_on = ["template_file.k8sCluster"]
#   connection {
#       type = "ssh"
#       host = "${digitalocean_droplet.rancherNode.ipv4_address}"
#       user = "root"
#       private_key = "${file("./modules/rancherNode/secrets/id_rsa")}"
#   }

#   provisioner "file" {
#     source = "./playbooks/install_rke.sh"
#     destination = "/root/install_rke.sh"
#   }

#   provisioner "file" {
#     source = "./playbooks/install_docker.sh"
#     destination = "/root/install_docker.sh"
#   }

#   provisioner "file" {
#     content = "${template_file.k8sCluster.rendered}"
#     destination = "/root/cluster-rke.yml"
#   }
  
#   provisioner "remote-exec" {
#     inline = [
#       # Run the operations script.
#       ". ./install_rke.sh",
#       "rke --version",
#       ". ./install_docker.sh",
#       "rke up --config cluster-rke.yml"
#     ]
#   }
# }