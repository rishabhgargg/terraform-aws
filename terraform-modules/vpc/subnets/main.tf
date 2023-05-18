resource "aws_subnet" "aws-subnets" {
  count             = length(var.subnets)
  vpc_id            = var.vpc_id
  cidr_block        = element(concat(var.subnets, [""]), count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "${var.name}-${count.index}-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
    # Network = "public Subnets"
  }
}