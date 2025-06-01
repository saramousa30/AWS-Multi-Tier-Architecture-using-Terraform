# ----------------------------------------------------------------------------- #
# ------------------------------- VPC Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

# ---------------------------------------------------------------------
# Creating a VPC
# ---------------------------------------------------------------------

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = var.vpc_name
    owner = "Sara_Mousa"
  }
}

# ---------------------------------------------------------------------
# Creating an Internet Gateway
# ---------------------------------------------------------------------

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "IGW"
    Owner = "Sara_Mousa"
  }
}

# ---------------------------------------------------------------------
# Creating public and private subnets
# ---------------------------------------------------------------------

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.vpc_public_subnets_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnets_cidr[count.index]
  availability_zone       = var.vpc_azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet-${count.index + 1}"
  }
}

# create Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.vpc_private_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_private_subnets_cidr[count.index]
  availability_zone = var.vpc_azs[count.index]
  tags = {
    Name = "Private_Subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "database_subnets" {
  count             = length(var.vpc_private_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_database_subnets_cidr[count.index]
  availability_zone = var.vpc_azs[count.index]
  tags = {
    Name = "Database_Subnet-${count.index + 1}"
  }
}

# ----------------------------------------------------------------------
# Creating a public route table and associate it with the public subnets
# ----------------------------------------------------------------------

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name  = "Public_RT"
    Owner = "Sara_Mousa"
  }
}

# Associating the public route table with the public subnets.
resource "aws_route_table_association" "public_subnets_RouteTable_Association" {
  count          = length(var.vpc_public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# ------------------------------------------------------------------------
# Creating Elastic IP and NAT Gateway
# ------------------------------------------------------------------------

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet 
resource "aws_eip" "eip_nat" {
  domain = "vpc"
  tags = {
    Name = "EIP_NAT"
  }
}
# create nat gateway in public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name  = "NAT_GW"
    Owner = "Sara_Mousa"
  }

  depends_on = [aws_internet_gateway.igw]
}



# ------------------------------------------------------------------------
# Creating a private route table and associate it with the private subnets
# ------------------------------------------------------------------------
# Creating route table.
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name  = "Private_RT"
    Owner = "Sara_Mousa"
  }
}

# Associating the Private route table with the Private subnets.
resource "aws_route_table_association" "private_subnets_RouteTable_Association" {
  count          = length(var.vpc_private_subnets_cidr)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "database_subnets_RouteTable_Association" {
  count          = length(var.vpc_database_subnets_cidr)
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

