resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.96.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.112.0/20"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.128.0/20"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]

  eks_managed_node_groups = {
    green = {
      min_size       = 1
      max_size       = 1
      desired_size   = 1
      instance_types = ["t2.micro"]
    }
  }
}
