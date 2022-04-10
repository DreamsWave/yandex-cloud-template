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

resource "yandex_function" "example-function" {
  name               = var.function_name
  user_hash          = data.archive_file.example-function-archive.output_base64sha256
  runtime            = "nodejs16"
  entrypoint         = "index.handler"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = var.service_account_id
  content {
    zip_filename = "${path.module}/../tmp/${var.function_name}.zip"
  }
}
data "archive_file" "example-function-archive" {
  type        = "zip"
  source_dir  = "${path.module}/../functions/${var.function_name}/dist"
  output_path = "${path.module}/../tmp/${var.function_name}.zip"
}




