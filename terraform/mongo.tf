# terraform {
#   required_providers {
#     mongodbatlas = {
#       source  = "mongodb/mongodbatlas"
#       version = "1.4.5"
#     }
#   }
# }

# provider "mongodbatlas" {}

# resource "mongodbatlas_project" "project" {
#   name   = var.project_name
#   org_id = var.org_id
# }

# resource "mongodbatlas_project_ip_access_list" "ip" {
#   project_id = mongodbatlas_project.project.id
#   cidr_block = var.cidr  
#   comment    = "The IP Address for accessing the cluster"
# }
# resource "mongodbatlas_cluster" "cluster" {
#   project_id             = mongodbatlas_project.project.id
#   name                   = var.cluster_name
#   mongo_db_major_version = var.mongodbversion
#   cluster_type           = "REPLICASET"
#   replication_specs {
#     num_shards = 1
#     regions_config {
#       region_name     = var.region
#       electable_nodes = 3
#       priority        = 7
#       read_only_nodes = 0
#     }
#   }
#   cloud_backup                 = true
#   auto_scaling_disk_gb_enabled = true
#   provider_name                = var.cloud_provider
#   provider_instance_size_name  = "M10"
# }

# resource "mongodbatlas_database_user" "user" {
#   username           = var.dbuser
#   password           = var.dbuser
#   project_id         = mongodbatlas_project.project.id
#   auth_database_name = "admin"

#   roles {
#     role_name     = "readWrite"
#     database_name = var.database_name 
#   }
#   labels {
#     key   = "Name"
#     value = "DB User1"
#   }
# }

# output "connection_strings" {
#     value = "mongodb+srv://${mongodbatlas_database_user.user.username}:${mongodbatlas_database_user.user.password}@${trim(mongodbatlas_cluster.cluster.connection_strings[0].standard_srv, "mongodb+srv://")}"
#     sensitive = true
# }

# output "ipaccesslist" {
#   value = mongodbatlas_project_ip_access_list.ip.ip_address
# }

# output "project_name" {
#   value = mongodbatlas_project.project.name
# }