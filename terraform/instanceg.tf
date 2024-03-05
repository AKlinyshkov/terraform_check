data "yandex_compute_image" "this" {
  name = "${var.image_name}-${var.image_tag}"
}

resource "yandex_compute_instance_group" "this" {
  name                = "nginx-ig"
  folder_id           = "${var.folder_id_val}"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = false
  depends_on = [yandex_resourcemanager_folder_iam_binding.this]
  load_balancer {
    target_group_name = "nginx-instance-group"
  } 
  instance_template {
    platform_id = "standard-v2"
    resources {
      memory = var.resources.memory 
      cores  = var.resources.cpu 
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.this.id}"
        size     = var.resources.disk 
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.this.id}"
      subnet_ids = [ for subnt in yandex_vpc_subnet.this : subnt.id ]
    }
    labels = var.labels 
    metadata = {
      ssh-keys = var.public_ssh_key_path != "" ? "cloud-user:${file(var.public_ssh_key_path)}" : "cloud-user:${tls_private_key.pk[0].public_key_openssh}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.vm_count 
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = var.deploy_policy.max_unavailable
    max_creating    = var.deploy_policy.max_creating
    max_expansion   = var.deploy_policy.max_expansion
    max_deleting    = var.deploy_policy.max_deleting
  }
}
