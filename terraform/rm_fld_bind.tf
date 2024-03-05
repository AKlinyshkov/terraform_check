resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = var.folder_id_val

  role = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}
