# variable "public_key" {
#   type        = string
#   description = "Public Programmatic API key to authenticate to Atlas"
#   default = "zfhbmwwy"
# }
# variable "private_key" {
#   type        = string
#   description = "Private Programmatic API key to authenticate to Atlas"
#   default = "a1044f67-354b-474f-a46e-b25f175aae05"
# }
# variable "org_id" {
#   type        = string
#   description = "MongoDB Organization ID"
#   default = "66315219521ec553291528b3"
# }
# variable "project_name" {
#   type        = string
#   description = "The MongoDB Atlas Project Name"
#   default = "prueba"
# }
# variable "cluster_name" {
#   type        = string
#   description = "The MongoDB Atlas Cluster Name"
#   default = "Cluster0"
# }
# variable "cloud_provider" {
#   type        = string
#   description = "The cloud provider to use, must be AWS, GCP or AZURE"
#   default = "AWS"
# }
# variable "region" {
#   type        = string
#   description = "MongoDB Atlas Cluster Region, must be a region for the provider given"
#   default = "sa-east-1"
# }
# variable "mongodbversion" {
#   type        = string
#   description = "The Major MongoDB Version"
#   default = "7.0"
# }
# variable "dbuser" {
#   type        = string
#   description = "MongoDB Atlas Database User Name"
#   default = "Iberson Silva"
# }
# variable "dbuser_password" {
#   type        = string
#   description = "MongoDB Atlas Database User Password"
#   default = "iberson123"
# }
# variable "database_name" {
#   type        = string
#   description = "The database in the cluster to limit the database user to, the database does not have to exist yet"
#   default = "test"
# }
# variable "ip_address" {
#   type        = string
#   description = "The IP address that the cluster will be accessed from, can also be a CIDR range or AWS security group"
#   default = "0.0.0.0/0"
# }
# variable "cidr" {
#   type        = string
#   description = "The CIDR range or AWS security group"
#   default = "0.0.0.0/0"
# }

# -----------------------------------------------
# variable "aws_account_id" {
#   type = string
#   default = "864899858564"
# }
# variable "aws_key_name" {
#   type = string
#   default = "terraform"
# }

# variable "aws_region" {
#   type = string
#   default = "us-east-2"
# }
# variable "aws_profile" {
#   type = string
#   default = "tf-developer"
# }

variable "region" { 
  description = "La región de AWS en la que se crearán los recursos" 
  type         = string 
  default = "us-east-2"
 } 

variable "ecs_cluster_name" { 
  description = "El nombre del clúster de ECS" 
  type         = string 
} 

variable "app_name" { 
  description = "El nombre de la aplicación" 
  type         = string 
} 

variable "vpc_id" { 
  description = "El ID de la VPC donde se crearán los recursos" 
  type         = string 
} 

variable "subnet_ids" { 
  description = "Una lista de ID de subred para el servicio de ECS" 
  type         = list(string) 
}

