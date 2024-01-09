resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.112.0/20"
  availability_zone = "us-east-1c"
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.128.0/20"
  availability_zone = "us-east-1d"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  # cluster_addons = {
  #   coredns = {
  #     most_recent = true
  #   }
  #   kube-proxy = {
  #     most_recent = true
  #   }
  #   vpc-cni = {
  #     most_recent = true
  #   }
  # }

  vpc_id                   = var.vpc_id
  subnet_ids               = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]

  # Self Managed Node Group(s)
  # self_managed_node_group_defaults = {
  #   instance_type                          = "m6i.large"
  #   update_launch_template_default_version = true
  #   iam_role_additional_policies = {
  #     AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  #   }
  # }

  # self_managed_node_groups = {
  #   one = {
  #     name         = "mixed-1"
  #     max_size     = 5
  #     desired_size = 2

  #     use_mixed_instances_policy = true
  #     mixed_instances_policy = {
  #       instances_distribution = {
  #         on_demand_base_capacity                  = 0
  #         on_demand_percentage_above_base_capacity = 10
  #         spot_allocation_strategy                 = "capacity-optimized"
  #       }

  #       override = [
  #         {
  #           instance_type     = "m5.large"
  #           weighted_capacity = "1"
  #         },
  #         {
  #           instance_type     = "m6i.large"
  #           weighted_capacity = "2"
  #         },
  #       ]
  #     }
  #   }
  # }

  # EKS Managed Node Group(s)
  # eks_managed_node_group_defaults = {
  #   instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  # }

  # eks_managed_node_groups = {
  #   blue = {}
  #   green = {
  #     min_size     = 1
  #     max_size     = 10
  #     desired_size = 1

  #     instance_types = ["t3.large"]
  #     capacity_type  = "SPOT"
  #   }
  # }

  # Fargate Profile(s)
  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        }
      ]
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "777777777777",
    "888888888888",
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
