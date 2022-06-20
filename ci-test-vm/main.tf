# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a new SSH key
resource "hcloud_ssh_key1" "ansible-test-ssh-key1" {
  name = "ssh-ts12"
  public_key = file(var.ssh_key)
}

# Create a server
resource "hcloud_server" "ansible-test-vm" {
  name = "ansible-test-instance-ts"
  image = "ubuntu-20.04"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys = [
    "ssh-ts12"
  ]

  provisioner "local-exec" {
    command = "sleep 20; ssh-keygen -R ${hcloud_server.ansible-test-vm.ipv4_address}; ssh-keyscan -t rsa -H ${hcloud_server.ansible-test-vm.ipv4_address} >> ~/.ssh/known_hosts"
  }
  depends_on = [
    hcloud_ssh_key1.ansible-test-ssh-key1
  ]
}

output "public_ip_address" {
  value = "${hcloud_server.ansible-test-vm.ipv4_address}"
}
