output "id" {
  description = "The ID of the created secret"
  value       = google_secret_manager_secret.secret.id
}

output "name" {
  description = "The name of the created secret"
  value       = google_secret_manager_secret.secret.name
}

output "version" {
  description = "The version of the created secret"
  value       = google_secret_manager_secret_version.version.name
}

output "project_id" {
  description = "GCP Project ID where secret was created"
  value       = google_secret_manager_secret.secret.project
}