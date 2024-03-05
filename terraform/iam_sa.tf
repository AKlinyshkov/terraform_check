resource "yandex_iam_service_account" "this" {
  name        = "vmmanager"
  description = "service account to manage VMs"
}
