module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name = var.cluster_name
  cluster_version = "1.24"

  vpc_id = module.dev-vpc.vpc_id
  subnet_ids = module.dev-vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = "dev-node"

      instance_types = ["t2.medium"]

      min_size = 1
      max_size = 4
      desired_size = 2
    }

  }
}