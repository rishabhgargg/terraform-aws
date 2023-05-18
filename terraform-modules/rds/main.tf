resource "aws_db_subnet_group" "rds-subnet" {
  name       = "db-subnet-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  subnet_ids = var.subnets

  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "db-subnet-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

resource "aws_db_parameter_group" "db_parameter" {
  name   = "db-parameter-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  family = var.family
  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "db-parameter-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

resource "aws_db_instance" "rds" {
  identifier                      = "${lookup(var.tags, "Name")}-${lookup(var.tags, "Environment")}-mysql"
  db_name                         = var.db_name
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  username                        = var.username
  password                        = var.password
  vpc_security_group_ids          = [var.vpc_security_group_id]
  storage_encrypted               = "true"
  deletion_protection             = "false"
  allocated_storage               = 1000
  enabled_cloudwatch_logs_exports = ["general"]
  performance_insights_enabled    = "false"
  publicly_accessible             = "false"
  parameter_group_name            = aws_db_parameter_group.db_parameter.name
  skip_final_snapshot             = "true"
  db_subnet_group_name            = aws_db_subnet_group.rds-subnet.name
  auto_minor_version_upgrade      = true
  backup_retention_period         = 7
  backup_window                   = "03:00-06:00"
  maintenance_window              = "Mon:00:00-Mon:03:00"
  copy_tags_to_snapshot           = false
  apply_immediately               = false
  port                            = var.port
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "db-parameter-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

