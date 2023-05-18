resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.ecr_name}-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "${var.ecr_name}-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}