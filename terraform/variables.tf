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

/**
 * Copyright 2021 Google LLC
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


// network variable

variable "project_id" {
  description = "Project ID where all this will be steup ."
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "GLOBAL"
}

variable "subnets" {
  description = "The list of subnets being created"
  type        = list(map(string))
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

variable "routes" {
  description = "List of routes being created in this VPC"
  type        = list(map(string))
  default     = []
}

variable "rules" {
  description = "List of custom rule definitions"
  type        = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
  default     = []
}

// Compute Engine Instance 

variable "instance_name" {
  description = "The instance name for compute engine VM"
  type        = string
  default     = "instance-1"

}

variable "machine_type" {
  description = "The machine type for compute engine VM"
  type        = string
  default     = "e2-medium"

}

variable "zone" {
  description = "The zone for deploying compute engine VM"
  type        = string
  default     = "us-central1-a"
}

variable "tags" {
  description = "The tags attached to the  compute engine VM"
  type        = list(string)
  default     = ["foo","bar"]

}

variable "image" {
  description = "The image family for the compute engine"
  type        = string
  default     = "debian-cloud/debian-9"
}

variable "compute_engine_sa" {
  description = "The service account attached to the compute engine"
  type        = string
  default     = ""
}

variable "compute_engine_sa_desc" {
  description = "The service account description attached to the compute engine"
  type        = string
  default     = ""
}
