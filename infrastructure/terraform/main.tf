terraform {
  required_version = ">= 1.5.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

# In einer Sovereign-Cloud/On-Premise-Umgebung provisioniert Terraform hier VMs.
# Dieses Skript generiert nach dem Provisioning dynamisch das Ansible-Inventory.
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content  = <<EOT
[k8s_nodes]
node01.enterprise.local ansible_host=10.122.10.11
node02.enterprise.local ansible_host=10.122.10.12

[k8s_nodes:vars]
ansible_user=devsecops
ansible_ssh_private_key_file=~/.ssh/id_rsa
EOT
}
