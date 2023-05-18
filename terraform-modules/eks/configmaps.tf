# locals{
#     aws_auth_configmap_data = {
#     mapUsers    = yamlencode(var.map_users)
#     mapAccounts = yamlencode(var.map_roles)
#   }
# }

# resource "kubernetes_config_map" "example" {
#   metadata {
#     name = "my-config"
#   }
#     data =local.aws_auth_configmap_data
# }