region = "ap-south-1"

# #Statefile Configuration
# s3_bucket_name = "tf-state-customer-engagement"
# dynamodb_table = "customer-engagement-tf-state-lock"

# VPC Module Variables
cidr_block = "172.17.0.0/22"
common_tags = {
  Namespace   = "customer-engagement"
  TG_Managed  = "true"
  Project     = "customer-engagement"
  Name        = "customer-engagement"
  Environment = "dev"
  Role        = "worker"
  Cluster     = "customer-engagement-dev"
}
dhcp_domain_name = "ap-south-1.compute.internal"
public_subnets   = ["172.17.3.0/26", "172.17.3.64/26", "172.17.3.128/26", "172.17.3.192/26"]
private_subnets  = ["172.17.0.0/25", "172.17.0.128/25", "172.17.1.0/25", "172.17.1.128/25"]
db_subnets       = ["172.17.2.0/26", "172.17.2.64/26", "172.17.2.128/26", "172.17.2.192/26"]
azs              = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

#Key_Pair
key_pair_name = "customer-engagement-dev"
public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcrnCbnJ9NatGwl4myqvJKRV4rKn0nuofniuACJtNMrJ81bYAgujkIzG2FCS9AqJBsAjNqY6vk4ED0RKhyGDInE/ESUeL7MC/U7Tlk2sQJ+Lfb/T9z+XFBRlKsdIFgRBMAnC67njntZdtjKih+oN9SsDjyCa53zpz/30YvWr4/gweAgBSPJVoYPgZZ3MVdrqCLPS2kzcB6j4Dsca3D1QQC1yiWTgAYPdfbvvyvVwHyXsE71DjxXumgJQlk4zCN9t/Y2ntNsrWjC1VMvJEiKkZtPwxJzAS0RUcaceOtTRfbVkyJBuwWcbjETAeQqa4WgRnDxLTvHKhuJL8JWoTZObRK2gxNA+/8ZWOWUFDBouZGjWA3oeu1RO0k42KRPXu3Zbkkh6ZlHJfbdM4d5UIv5DYNeikdC2Ux5XN+t8LQdEE8GJhhi9ZPpyCjcq8avH1FdHtmhi8jS4GTJiFlqNtwYPpQ6B1vVUzQ18h18BKyXtqTUGQRG8jmdbgc0n3D14dQLXU= rishabh@INDRishabh-Garg"

#Bastion 
instance_count              = 1
instance_type               = "t2.micro"
associate_public_ip_address = true
iam_instance_profile        = "default-instance"

#RDS
family = "mysql8.0"

engine         = "mysql"
engine_version = "8.0.28"
instance_class = "db.t3.small"
username       = "customerai"
password       = "customer123"
port           = "3306"
db_name        = "customerengagementdev"
parameters = [
  {
    apply_method = "pending-reboot"
    name         = "character_set_database"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "innodb_strict_mode"
    value        = "0"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_client"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_connection"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_database"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_filesystem"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_results"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "character_set_server"
    value        = "latin1"
  },
  {
    apply_method = "pending-reboot"
    name         = "local_infile"
    value        = "1"
  },
  {
    apply_method = "pending-reboot"
    name         = "lower_case_table_names"
    value        = "1"
  }

]

#ECR
ecr_name = "customer-engagement-ui"

#Launch Template
launch_template_instance_type = "t2.micro"
volume_size                   = 30
key_pair                      = "Customer-Engagement"
vpc_cidr_block                = "172.16.0.0/22"
# transit_gateway_id            = "tgw-040c4fd430e9b151c"

# #FSX
# storage_capacity            = 1200
# deployment_type             = "PERSISTENT_1"
# per_unit_storage_throughput = 200

#eks
cluster_name        = "customer-engagement-dev"
public_access_cidrs = ["0.0.0.0/0"]


#NodeGroup
desired_capacity = 1
min_size         = 1
max_size         = 3