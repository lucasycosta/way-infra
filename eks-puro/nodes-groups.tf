//NODES SÃO AS MÁQUINAS VIRTUAIS QUE IRAM EXECUTAR OS PODS KUBERNETES, ESSES NODES SÃO EXECUTADOS DENTRO DE UMA MÁQUINA
//MAIOR QUE É O CLUSTER EKS

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.cluster_eks_way.name
  node_group_name = "wayconsig"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.private_subnets  //é uma boa pratica passar apenas a subnetes privadas

  //descrição do EC2
  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = 20
  instance_types = ["t3a.medium"]

  //escalabilidade
  scaling_config {
    desired_size = 1  //desejavel que sempre se mantenha
    max_size     = 2  //máximo
    min_size     = 1  //mínimo
  }

  update_config {     //indisponivel quando estiver ocorrendo um update (quantidade ou % das instancias)
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy
  ]
}