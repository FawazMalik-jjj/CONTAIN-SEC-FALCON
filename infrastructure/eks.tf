# Create VPC and Subnets
resource "aws_vpc" "falcon_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "falcon-vpc"
  }
}

# Create Private Subnets (for EKS worker nodes)
resource "aws_subnet" "private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.falcon_vpc.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "private-subnet-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Create Public Subnets (for load balancers)
resource "aws_subnet" "public_subnets" {
  count             = 2
  vpc_id            = aws_vpc.falcon_vpc.id
  cidr_block        = "10.0.${count.index + 3}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "public-subnet-${count.index + 1}"
    "kubernetes.io/role/elb" = "1"
  }
}

# Internet Gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.falcon_vpc.id
  tags = {
    Name = "falcon-igw"
  }
}

# NAT Gateway for private subnets
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "falcon-nat"
  }
}

# Add these to your EKS cluster configuration
resource "aws_eks_cluster" "falcon" {
  name     = "secure-falcon"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.28"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnets[0].id,
      aws_subnet.private_subnets[1].id
    ]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  
  depends_on = [
    aws_nat_gateway.nat
  ]
}

# Required data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}