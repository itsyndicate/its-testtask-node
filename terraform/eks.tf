  module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

  cluster_name = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  subnet_ids = module.task-vpc.public_subnets
  vpc_id = module.task-vpc.vpc_id

  

  eks_managed_node_groups = [
    {
        key_name = aws_key_pair.mykey.key_name
        vpc_id = module.task-vpc.vpc_id
        subnet_ids = module.task-vpc.private_subnets
        instance_type = var.eks_mng_node_instance_type
        name = "worker_group"
        asg_desired_capacity = 1
    },
    {
        vpc_id = module.task-vpc.vpc_id
        subnet_ids = module.task-vpc.private_subnets
        instance_type = var.eks_mng_node_instance_type
        name = "worker_group"
        asg_desired_capacity = 1
    }
  ]
   

}

resource "aws_key_pair" "mykey"  {
            key_name = "mykeytest"
            public_key = file(var.private_key_worker_nodes)
        }