data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index + 1}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.name}-private-${count.index + 1}"
    Tier = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}




# ---------------------------------------------------------
# PRIVATE ROUTE TABLE
# ---------------------------------------------------------
# Create a dedicated route table for private subnets.
#
# AWS automatically provides a local route for communication
# between resources inside the VPC.
#
# We intentionally do not add a default internet route here.
# Therefore, this route table does not provide direct internet
# access through the Internet Gateway.
# ---------------------------------------------------------

resource "aws_route_table" "private" {
  # Associate the route table with our VPC.
  vpc_id = aws_vpc.this.id

  # Give the route table a meaningful name.
  tags = {
    Name = "${var.name}-private-rt"
    Tier = "private"
  }
}


# ---------------------------------------------------------
# PRIVATE SUBNET ROUTE TABLE ASSOCIATIONS
# ---------------------------------------------------------
# Associate each private subnet with the private route table.
#
# count = 2 creates two association resources.
# count.index selects subnet 0 and then subnet 1.
# Both subnets use the same private route table.
# ---------------------------------------------------------

resource "aws_route_table_association" "private" {
  # Create one association for each private subnet.
  count = 2

  # Select the private subnet for this association.
  subnet_id = aws_subnet.private[count.index].id

  # Associate the subnet with the dedicated private route table.
  route_table_id = aws_route_table.private.id
}
