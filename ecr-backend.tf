#Module to create ecr for QS
module "ecr_backend" {
  source   = "./terraform-modules/ecr"
  ecr_name = "customer-engagement-backend"
  tags     = var.common_tags
}