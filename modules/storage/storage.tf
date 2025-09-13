resource "google_storage_bucket" "storage" {
  name = var.bucket_name
  location = "us"
  force_destroy = true
  uniform_bucket_level_access = true
}

