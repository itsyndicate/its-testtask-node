

resource "aws_security_group" "worker_group_ssh" {
    name_prefix = "worker_group_ssh"
    vpc_id = module.task-vpc.vpc_id

    ingress{
        from_port = 0
        to_port = 0 
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]

    }
    egress{
        from_port = 0
        to_port = 0 
        protocol = "tcp"

        cidr_blocks = ["0.0.0.0/0"]

    }
}

module "task-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "task-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks 
  public_subnets = var.public_subnet_cidr_blocks 
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/task-eks" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/task-eks" = "shared"
    "kubernetes.io/cluster/role/internal-elb" = 1

}

public_subnet_tags = {
    "kubernetes.io/cluster/task-eks" = "shared"
    "kubernetes.io/cluster/role/elb" = 1
}
}

