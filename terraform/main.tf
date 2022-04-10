terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.73.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

provider "random" {}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_function" "example-function" {
  name               = var.function_name
  user_hash          = random_uuid.get.result
  runtime            = "nodejs16"
  entrypoint         = "dist/index.handler"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = var.service_account_id
  content {
    zip_filename = "../${var.function_name}.zip"
  }
}

resource "random_uuid" "get" {}