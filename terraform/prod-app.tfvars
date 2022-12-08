#AWS_profile
aws_region = "us-east-1"
aws_profile = "default"

#module_vpc
vpc_cidr_block = "10.0.0.0/16"
private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24"]
private_key_worker_nodes = "/Users/mac/.ssh/id_rsa.pub"

#module_eks
eks_cluster_name = "task-eks"
eks_cluster_version = "1.22"
eks_mng_node_instance_type = "t2.small"

#module_efs
efs_performance_mode = "generalPurpose"
efs_throughput_mode = "bursting"
efs_name = "efs-task-eks"