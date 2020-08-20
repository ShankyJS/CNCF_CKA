variable "digitalocean_token" {
    description = "Private token to create resources"
} 

variable "domain_name" {
    description = "Name of the domain that is already created on Digitalocean"
}
variable "record_name" {
    description = "Name of the record of the used domain"
}

variable "ssh_key_name" {
    description = "Name of the SSH key to the digitalocean resource"
}