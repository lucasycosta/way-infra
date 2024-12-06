resource "aws_eks_cluster" "cluster_eks_way" {
  name = var.eks_name
  role_arn = aws_iam_role.eks_role.arn
  version  = "1.31"

  vpc_config {  //subnetes publicas e privadas
    subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

    //Acesso ao cluster para executar comandos kubectl
    endpoint_private_access = true
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"] //quem pode acessar, deve ser o mais limitado possível
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
  ]
}
