### IAM
resource "yandex_iam_service_account" "this" {
  name        = var.service_account_name
  description = "Service account to manage Functions"
}
resource "yandex_resourcemanager_folder_iam_member" "this" {
  for_each  = toset(["editor", "serverless.functions.invoker"])
  folder_id = var.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
  role      = each.value
}
# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#   service_account_id = yandex_iam_service_account.this.id
#   description        = "static access key for YMQ"
# }

### Functions
resource "yandex_function" "yc-function" {
  name               = "yc-function"
  description        = "Yandex Cloud Function example"
  user_hash          = data.archive_file.yc-function.output_base64sha256
  runtime            = "nodejs16"
  entrypoint         = "index.handler"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = yandex_iam_service_account.this.id
  # tags               = ["some_tag"]
  content {
    zip_filename = "${path.module}/../functions/yc-function/build.zip"
  }
  # environment        = {}
  # depends_on       = [yandex_message_queue.queue]
}
data "archive_file" "yc-function" {
  type        = "zip"
  source_dir  = "${path.module}/../functions/yc-function/dist"
  output_path = "${path.module}/../functions/yc-function/build.zip"
}

### Triggers
# resource "yandex_function_trigger" "ymq-trigger" {
#   name        = "ymq-trigger"
#   description = "Trigger for ..."
#   folder_id   = var.folder_id
#   message_queue {
#     queue_id           = yandex_message_queue.queue.arn
#     service_account_id = yandex_iam_service_account.this.id
#     batch_cutoff       = 1
#     batch_size         = 1
#   }
#   function {
#     id                 = yandex_function.yandex-cloud-function.id
#     tag                = "$latest"
#     service_account_id = yandex_iam_service_account.this.id
#   }
# }
# resource "yandex_function_trigger" "cron-trigger" {
#   name        = "cron-trigger"
#   description = "Cron trigger"
#   folder_id   = var.folder_id
#   timer {
#     cron_expression = "0/15 * * * ? *"
#   }
#   function {
#     id                 = yandex_function.yandex-cloud-function.id
#     tag                = "$latest"
#     service_account_id = yandex_iam_service_account.this.id
#   }
# }

### Message Queue
# resource "yandex_message_queue" "queue" {
#   name                      = "ymq"
#   receive_wait_time_seconds = 10
#   access_key                = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key                = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

#   depends_on = [yandex_resourcemanager_folder_iam_member.this, yandex_iam_service_account_static_access_key.sa-static-key]
# }