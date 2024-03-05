terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    } 
    local = {
      source = "hashicorp/local"
      version = "2.4.1"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token_val
  cloud_id  = var.cloud_id_val
  folder_id = var.folder_id_val
}
