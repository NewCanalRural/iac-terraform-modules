variable "project_id" {
  description = "The project ID to manage the Secret Manager resources"
  type        = string
}

variable "name" {
  description = "The name of the secret to create."
  type        = string
}

variable "labels" {
  type        = map(string)
  description = "The map of labels to be added to the defined secret."
  default     = {}
}

variable "secret_data" {
  description = "The secret data. Must be no larger than 64KiB. Note: This property is sensitive and will not be displayed in the plan."
  type        = string
  default     = null
  sensitive   = true
}

variable "user_managed_replication" {
  description = <<-EOT
    Replication parameters that will be used for the defined secret.
    If not provided, the secret will be automatically replicated using Google-managed key without any regional restrictions.
    Example:
      user_managed_replication = [
        {
          location = "us-central1"
          kms_key_name = "projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING_NAME/cryptoKeys/KEY_NAME"
        },
        {
          location = "europe-west1"
          kms_key_name = "projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING_NAME/cryptoKeys/KEY_NAME"
        }
      ]
  EOT
  type = list(object({
    location     = string,
    kms_key_name = string,
  }))
  default = []
}

variable "automatic_replication" {
  description = <<-EOT
    Automatic replication parameters that will be used for the defined secret.
    If not provided, automatic replication is enabled and Google-managed key is used by default.
    Example:
      automatic_replication = {
        kms_key_name = "projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING_NAME/cryptoKeys/KEY_NAME"
      }
  EOT
  type = object({
    kms_key_name = optional(string, null)
  })
  default = {}
}