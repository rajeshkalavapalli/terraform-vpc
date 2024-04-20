resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
        Name = local.Name
    }
  )
}

# attaching internet gateway 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name = local.Name
    }
  )
}
# creating aws subnets

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.public_subnets_tags,
    {
        Name = "${local.Name}-public-${local.az_names[count.index]}"
    }
  )
}

# creating aws private 

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.private_subnets_tags,
    {
        Name = "${local.Name}-private-${local.az_names[count.index]}"
    }
  )
}

# creating aws database

resource "aws_subnet" "database" {
  count = length(var.database_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.database_subnets_tags,
    {
        Name = "${local.Name}-database-${local.az_names[count.index]}"
    }
  )
}

# creating eip

resource "aws_eip" "eip" {
  domain           = "vpc"
  
}

# creating natgatway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id 
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.natgatway_tags,
    {
        Name = local.Name
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


# creating public route  table 
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    var.common_tags,
    var.public_route_table_tags,

    {
        Name = "${local.Name}-public_route_table"
    }

  )
}


# creating private route  table 

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    var.common_tags,
    var.private_route_table_tags,

    {
        Name = "${local.Name}-private_route_table"
    }

  )
}

# creating database route  table 

resource "aws_route_table" "database_route" {
  vpc_id = aws_vpc.main.id


  tags = merge(
    var.common_tags,
    var.database_route_table_tags,

    {
        Name = "${local.Name}-database_route_table"
    }

  )
}


# creating public route 

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}


# creating private route 
resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private_route.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}

# creating database route 
resource "aws_route" "datbase_route" {
  route_table_id            = aws_route_table.database_route.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id 
}

#  public subnet association 

resource "aws_route_table_association" "public_association" {
  count = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_route.id
}


# private subnet association 
resource "aws_route_table_association" "private_association" {
  count = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

# database subnet association 
resource "aws_route_table_association" "database_association" {
  count = length(var.database_subnets_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database_route.id
}



