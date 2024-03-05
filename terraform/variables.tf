variable "image_name" {
  type        = string
  description = "Image name"
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}

variable "resources" {
  type = object({
    disk = number
    cpu = number
    memory = number
  })
}

variable "deploy_policy" {
  type = object({
    max_unavailable = number
    max_creating = number
    max_expansion = number
    max_deleting = number
  })
}

variable "vm_count" {
  type = number
  description = "Count of virtual machines"
}


variable "nlb_healthcheck" {
  type = object({
    name = string
    port = number
    path = string
  })
}

variable "listener_port" {
  type = number
  description = "listener port"
}


variable "cidr_blocks" {
  type = list(list(string))
  description = ""
}

variable "labels" {
  type = map(string)
  description = ""
}

variable "public_ssh_key_path" {
  type = string
  description = "path to public ssh key file"
}

variable "az" {
  type = list(string)
  description = "List of availability zones"
}


variable "token_val" {
  type = string
}

variable "folder_id_val" {
  type = string
}

variable "cloud_id_val" {
  type = string
}
