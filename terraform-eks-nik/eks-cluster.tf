module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name       = "${var.cluster_name}-cluster"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # ✅ Attach existing SG to EKS control plane
  cluster_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  # ✅ Important fix: Define cluster version
  kubernetes_version = "1.30"

  enable_cluster_creator_admin_permissions = true
  enable_irsa                             = true
  endpoint_public_access                  = true

  tags = {
    cluster = "demo"
  }

  eks_managed_node_groups = {
    eks-cluster = {
      ami_type               = "AL2023_x86_64_STANDARD"
      instance_types         = ["t2.medium"]
      vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }
}
