module "eks" {

  # Import the module template  
  source = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Cluster info (Control Plane)
  name = local.name
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  # Control plane is managed by AWS using Intranet (Control Plane Network)
  control_plane_subnet_ids = module.vpc.intra_subnets  
  
  kubernetes_version = "1.29" 

  # Managing nodes in cluster
  eks_managed_node_groups = {
    nik-cluster-ng = {
      instance_type = "t2.medium"  # Use string instead of list

      scaling_config = {
        desired_size = 1
        max_size     = 2
        min_size     = 1
        capacity_type = "SPOT"
      }
    }
  
    cluster_addons = {
     vpc-cni = {
        most-recent = true
     }

     kube-proxy = {
        most-recent = true
     }

     core-dns = {
        most-recent = true
     }

   }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}


