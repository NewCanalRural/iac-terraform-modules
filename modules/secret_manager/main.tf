resource "google_secret_manager_secret" "secret" {
  project   = var.project_id
  secret_id = var.name
  labels    = var.labels
  replication {
    dynamic "auto" {
      for_each = length(var.user_managed_replication) > 0 ? [] : [1]
      content {
        dynamic "customer_managed_encryption" {
          for_each = var.automatic_replication.kms_key_name != null ? [var.automatic_replication.kms_key_name] : []
          content {
            kms_key_name = customer_managed_encryption.value
          }
        }
      }
    }
    dynamic "user_managed" {
      for_each = length(var.user_managed_replication) > 0 ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.user_managed_replication
          content {
            location = replicas.value.location
            dynamic "customer_managed_encryption" {
              for_each = replicas.value.kms_key_name != null ? [replicas.value.kms_key_name] : []
              content {
                kms_key_name = customer_managed_encryption.value
              }
            }
          }
        }
      }
    }
  }
}

resource "google_secret_manager_secret_version" "version" {
  secret      = google_secret_manager_secret.secret.id
  payload     = var.secret_data
}