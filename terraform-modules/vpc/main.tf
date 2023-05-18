# VPC ID
# Resource to create vpc id
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "${lookup(var.tags, "Name")}-${lookup(var.tags, "Environment")}-VPC"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

# Private subnet_ids
# Module to create private subnet ids
module "private_subnets" {
  source  = "./subnets"
  vpc_id  = aws_vpc.main.id
  subnets = var.private_subnets
  azs     = var.azs
  tags    = var.tags
  name    = "pvt-sub"
}

# Public_subnet_ids
# Module to create public subnet ids
module "public_subnets" {
  source  = "./subnets"
  vpc_id  = aws_vpc.main.id
  subnets = var.public_subnets
  azs     = var.azs
  tags    = var.tags
  name    = "pub-sub"
}

# DB_subnet_ids
# Module to create DB subnet ids
module "db_subnets" {
  source  = "./subnets"
  vpc_id  = aws_vpc.main.id
  subnets = var.db_subnets
  azs     = var.azs
  tags    = var.tags
  name    = "db-sub"
}

# Internet Gateway
# Resource to create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "IG-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Network     = "public"
    Environment = "${lookup(var.tags, "Environment")}"
  }
  depends_on = [aws_vpc.main]
}

# Route Table Public
# Resource to create Public Route Table 
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  # route {
  #   cidr_block = var.vpc_cidr_block
  #   gateway_id = var.transit_gateway_id
  # }
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "public-rt-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Network     = "public Subnets"
    Environment = "${lookup(var.tags, "Environment")}"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Route Table Association
# Resource to attach public subnets to Public Route Table 
resource "aws_route_table_association" "public_association" {
  count          = length(module.public_subnets.subnet_ids)
  subnet_id      = module.public_subnets.subnet_ids[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

# Elastic IP
# Resource to create Elastic IP
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "EIP-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
  depends_on = [aws_vpc.main]
}

# NAT Gateway
# Resource to create Nat Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.public_subnets.subnet_ids[0]
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "NAT-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
  depends_on = [aws_eip.nat_eip]
}


# Route Table Private
# Resource to create Private Route Table 
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  # route {
  #   cidr_block = var.vpc_cidr_block
  #   gateway_id = var.transit_gateway_id
  # }
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "private-rt-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Network     = "private Subnets"
    Environment = "${lookup(var.tags, "Environment")}"
  }
  depends_on = [aws_nat_gateway.nat_gateway, aws_vpc.main]
}



# Route Table Association
# Resource to attach private subnets to private Route Table 
resource "aws_route_table_association" "private_association" {
  count          = length(module.private_subnets.subnet_ids)
  subnet_id      = module.private_subnets.subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
  depends_on = [
    aws_route_table.private_route_table
  ]
}


# Route Table Association
# Resource to attach db subnets to private Route Table 
resource "aws_route_table_association" "db_association" {
  count          = length(module.db_subnets.subnet_ids)
  subnet_id      = module.db_subnets.subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
  depends_on = [
    aws_route_table.private_route_table
  ]
}


# DHCP OPTIONS
# Resource to create dhcp options
resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = var.dhcp_domain_name
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    Namespace   = "${lookup(var.tags, "Namespace")}"
    TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
    Project     = "${lookup(var.tags, "Project")}"
    Name        = "DHCP-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
    Environment = "${lookup(var.tags, "Environment")}"
  }
}

# DHCP Options Association
# Resource to attch dhcp_option with vpc_id
resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
  depends_on = [
    aws_vpc_dhcp_options.dhcp_options, aws_vpc.main
  ]
}






