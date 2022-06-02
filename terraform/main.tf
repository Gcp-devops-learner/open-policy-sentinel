/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


// Network Module

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 4.0"

    project_id   = var.project_id
    network_name = var.network_name
    routing_mode = var.routing_mode
    subnets = var.subnets
    secondary_ranges = var.secondary_ranges
    routes = var.routes
}

// firewall module 
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name
  rules        = var.rules
}

// Compute resources

resource "google_compute_instance" "default" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = module.vpc.network_name
    subnetwork = var.subnets[0].subnet_name
    subnetwork_project = var.project_id

    access_config {
      // Ephemeral public IP
    }
  }
  depends_on = [
    module.vpc
  ]

}