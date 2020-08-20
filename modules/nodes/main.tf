variable "ssh_key_name" {

}

variable "masterNodeVmSize" {

}

variable "workerNodeVmSize" {

}

resource "digitalocean_ssh_key" "ssh_key" {
  name		    = "${var.ssh_key_name}"
  public_key	= "${file("./modules/nodes/secrets/id_rsa.pub")}"
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
  size        = var.masterNodeVmSize
  ssh_keys    = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
  vpc_uuid    = digitalocean_vpc.int1-vpc.id
  }

resource "digitalocean_droplet" "workerNode" {
  image       = "ubuntu-18-04-x64"
  name        = "workerNode"
  region      = "sfo2"
  size        = var.workerNodeVmSize
  ssh_keys    = ["${digitalocean_ssh_key.ssh_key.fingerprint}"]
  vpc_uuid    = digitalocean_vpc.int1-vpc.id
  }

resource "null_resource" "requirementsInstallation" {
  connection {
      type = "ssh"
      host = "${digitalocean_droplet.masterNode.ipv4_address}"
      user = "root"
      private_key = "${file("./modules/nodes/secrets/id_rsa")}"
  }

  provisioner "file" {
    source = "./playbooks/install_prerequisites.sh"
    destination = "/root/install_prerequisites.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      # Run the operations script.
      ". ./install_prerequisites.sh",
    ]
  }
}