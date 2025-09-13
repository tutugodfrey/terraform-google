terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
  backend "gcs" {
    bucket = "tf-bucket-890737"
    prefix = "terraform/state"
  }
}

provider "google" {
  zone = var.zone
  region = var.region
  project = var.project_id
}

module "instances" {
  source = "./modules/instances"
  zone = var.zone
  region = var.region
  project_id = var.project_id
}

module "storage" {
  source = "./modules/storage"
}


module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = var.project_id
    network_name = var.vpc_name
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.region
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = var.region
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "Network vpc"
        },
    ]
}

resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
	network = "projects/${var.project_id}/global/networks/${var.vpc_name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

