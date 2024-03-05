resource "yandex_lb_network_load_balancer" "this" {
  name = "${local.preffix}network-load-balancer"
  labels = var.labels
  
  listener {
    name = "my-listener"
    port = var.listener_port
    target_port = 8800
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.this.load_balancer.0.target_group_id}"

    healthcheck {
      name = var.nlb_healthcheck.name
      http_options {
        port = var.nlb_healthcheck.port
        path = var.nlb_healthcheck.path
      }
    }
  }
}
