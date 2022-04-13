terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.73.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.2"
    }
  }
}