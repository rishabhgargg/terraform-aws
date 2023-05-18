#Module to create ecr for UI
module "ecr_ui" {
  source   = "./terraform-modules/ecr"
  ecr_name = "customer-engagement-ui"
  tags     = var.common_tags
}