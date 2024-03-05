resource "tls_private_key" "pk" {
  count = var.public_ssh_key_path == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 3072
}

resource "local_sensitive_file" "my-key" {
  content = tls_private_key.pk[0].private_key_openssh
  filename = "pk"
  file_permission = "0600"
}
