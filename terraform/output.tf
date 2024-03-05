output "loadbalancer_ip_addr" {
  description = "Public IP address of loadbalancer instance"
  value = [ 
    for listener in yandex_lb_network_load_balancer.this.listener : 
      [ for eas in listener.external_address_spec : eas.address ]
  ]
}
