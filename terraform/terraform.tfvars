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

 #TODO if project is create denable the srevice at least 
 #TODO somehow during project creation snow ticket a set of org polocies should be set or disabled. 

//terraform_service_account = "terraform-sa@my-sellercloud.iam.gserviceaccount.com"
# Need to be passed only when create_project variable is set to true 

project_id                = "pentagon-324205"
network_name              = "design-pattern-1-bu1-network"

subnets = [
  {
    subnet_name   = "subnet-01"
    subnet_ip     = "10.10.10.0/24"
    subnet_region = "us-central1"
    subnet_private_access = true
  },
  {
    subnet_name           = "subnet-02"
    subnet_ip             = "10.10.20.0/24"
    subnet_region         = "us-central1"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
  {
    subnet_name               = "subnet-03"
    subnet_ip                 = "10.10.30.0/24"
    subnet_region             = "us-central1"
    subnet_flow_logs          = "true"
    subnet_flow_logs_interval = "INTERVAL_10_MIN"
    subnet_flow_logs_sampling = 0.7
    subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
  }
]
secondary_ranges = {
  subnet-01 = [
    {
      range_name    = "subnet-01-secondary-01"
      ip_cidr_range = "192.168.64.0/24"
    },
    {
      range_name    = "subnet-01-secondary-02"
      ip_cidr_range = "192.168.32.0/24"
    },
  ]

  subnet-02 = []
}

rules = [{
    name                    = "allow-ssh-ingress"
    description             = "Allow ssh ingress for public"
    direction               = "INGRESS"
    priority                = "1000"
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  },{
    name                    = "allow-https-ingress"
    description             = "Allow https ingress for public"
    direction               = "INGRESS"
    priority                = "1000"
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["https","app"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["443"]
    }]
    deny = []
    log_config = {
       metadata = "EXCLUDE_ALL_METADATA"
    }
  }]

//compute engine
compute_engine_sa  = "compute-engine-sa"
compute_engine_sa_desc = "Service accout to attach compute engine"
image = "windows-cloud/windows-2022"