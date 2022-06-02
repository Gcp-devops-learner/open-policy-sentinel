provider "google" {
  project     = "pentagon-324205"
}


terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.11.0"
    }
  }
}

