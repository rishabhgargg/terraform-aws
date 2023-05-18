# # Network
# variable "aws_region" {
#   type    = string
#   default = null
# }

variable "region" {
  type        = string
  description = "Region for the services to be deployed"
}

variable "common_tags" {
  type = map(any)


}
#VPC Variables
variable "cidr_block" {
  type        = string
  description = "cidr_block for VPC"
}

variable "dhcp_domain_name" {

}

variable "public_subnets" {

}

variable "private_subnets" {

}

variable "db_subnets" {

}

variable "azs" {

}

variable "key_pair_name" {

}

variable "public_key" {

}

#Bastion Variables
variable "instance_count" {

}

variable "instance_type" {

}

variable "associate_public_ip_address" {

}


variable "iam_instance_profile" {

}

#RDS Variables
variable "family" {

}

variable "parameters" {

}

variable "engine" {
  description = "The database engine to use"
  type        = string

}

variable "engine_version" {
  description = "The engine version to use"
  type        = string

}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string

}

variable "username" {
  description = "Username for the master DB user"
  type        = string

}

variable "password" {
  type = string
}

variable "port" {

}
variable "db_name" {

}
variable "ecr_name" {

}
variable "launch_template_instance_type" {

}
variable "volume_size" {

}
variable "vpc_cidr_block" {

}

# variable "transit_gateway_id" {

# }

#FSX 
variable "storage_capacity" {

}
variable "per_unit_storage_throughput" {

}
variable "deployment_type" {

}

#EKS Variables
variable "cluster_name" {

}

variable "public_access_cidrs" {

}
variable "map_roles" {

}
variable "map_users" {

}

#NodeGroup Variables

variable "desired_capacity" {

}

variable "min_size" {

}

variable "max_size" {

}

variable "key_pair" {

}

variable "s3_bucket_name" {

}

variable "dynamodb_table" {

}