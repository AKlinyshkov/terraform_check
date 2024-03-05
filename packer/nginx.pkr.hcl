source "yandex" "tstimg" {
  token = var.token_val
  folder_id = var.folder_id_val
  zone = var.zone_val
  
  image_name          = "nginx-${var.image_tag}"
  image_family        = "centos-web-server"
  image_description   = "my custom centos with nginx"
  
  source_image_family = "centos-7"
  subnet_id           = "e9b6s3a2f1e2qmisa6h5"
  use_ipv4_nat        = true
  disk_type           = "network-ssd"
  ssh_username        = "centos"
  
}

build {
  sources = ["source.yandex.tstimg"]

  provisioner "shell" {
      inline = ["yum provides /usr/sbin/semanage", "sudo yum install policycoreutils-python -y", "sudo semanage port -a -t http_port_t -p tcp 8800"]
  }

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
     
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]
    
    user = "cloud-user"
  }
}
