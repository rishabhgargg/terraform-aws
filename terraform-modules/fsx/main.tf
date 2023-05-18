resource "aws_fsx_lustre_file_system" "fsx" {
  storage_capacity            = var.storage_capacity
  deployment_type             = var.deployment_type
  subnet_ids                  = [var.subnet_ids]
  per_unit_storage_throughput = var.per_unit_storage_throughput
  security_group_ids          = [var.security_group_ids]
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "FSX-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}