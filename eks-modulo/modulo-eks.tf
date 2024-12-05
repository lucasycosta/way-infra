//UTILIZANDO MODULOS NÃO PRECISA CRIAR SEPARADO ALGUNS RECURSOS, COMO OS IAM

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.30.1"

  // definições d0 cluster
  cluster_name = var.eks_name
  cluster_version = "1.31"

  //definições de VPC
  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true 

  //definições de instancias
  eks_managed_node_groups = {
    eks_nodes = {
        min_size = 1
        max_size = 1
        desired_size = 1

        instance_types = ["t3.medium"]
    }
  }
}