# Creating the security groups
resource "aws_security_group" "securitygroup" {
  name   = "${lookup(var.tags, "Project")}-${var.name}-SG"
  vpc_id = var.vpc
  dynamic "ingress" {
    for_each = var.ports[*]
    content {
      from_port   = ingress.value.fromport
      to_port     = ingress.value.toport
      cidr_blocks = [ingress.value.source]
      protocol    = "tcp"
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "security-group-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

