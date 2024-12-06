//modulo de VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = format("%s-cpv", var.eks_name)
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]            //zonas de disponibilidade
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]         //subnetes privadas
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]   //subnetes publicas

  enable_nat_gateway = true   //habilita o nat, conexão com a internet

private_subnet_tags = {       //tags em cada subnet para que a AWS entenda como manipula-las
    "Name" = format("%s-sub-private", var.eks_name),
    "kubernetes.io/role/internal-elb" = 1,                //criação de um loadbalancer interno nas subs-privadas
    "kubernetes.io/cluster/${var.eks_name}" = "shared"    //subnet compartilhada com o cluster
}

public_subnet_tags = {       
    "Name" = format("%s-sub-public", var.eks_name),
    "kubernetes.io/role/elb" = 1,                         //loadbalancer publico
    "kubernetes.io/cluster/${var.eks_name}" = "shared" 
}
}