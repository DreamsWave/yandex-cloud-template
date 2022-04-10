terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.73.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
provider "archive" {}

resource "yandex_function" "function" {
  for_each = toset(var.functions)
  name               = each.key
  user_hash          = data.archive_file.function-archive[each.key].output_base64sha256
  runtime            = "nodejs16"
  entrypoint         = "index.handler"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = var.service_account_id
  content {
    zip_filename = "${path.module}/../tmp/${each.key}.zip"
  }
}
data "archive_file" "function-archive" {
  for_each = toset(var.functions)
  type        = "zip"
  source_dir  = "${path.module}/../tmp/${each.key}"
  output_path = "${path.module}/../tmp/${each.key}.zip"
}


