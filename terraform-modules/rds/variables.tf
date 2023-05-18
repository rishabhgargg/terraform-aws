# variable "Project" {
#   type        = string
# }





# variable "name" {
#   description = "The DB name to create. If omitted, no database is created initially"
#   type        = string

# }







# variable "parameter_group_name" {

# }

# variable "region" {

# }

# variable "db_subnet" {
#   type = list
# }

# variable "vpc" {

# }

# variable "env" {

# }

variable "family" {

}

variable "parameters" {

}

variable "tags" {

}

variable "subnets" {

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

variable "vpc_security_group_id" {

}

variable "port" {

}

variable "db_name" {

}