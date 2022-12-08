variable "aws_region" {}
variable "aws_profile" {}

variable "private_subnet_cidr_blocks"{}
variable "public_subnet_cidr_blocks"{}
variable "private_key_worker_nodes" {}

variable "eks_cluster_name" {}
variable "eks_cluster_version" {}
variable "eks_mng_node_instance_type" {}
variable "vpc_cidr_block"{}

variable "efs_performance_mode" {}
variable "efs_throughput_mode" {}
variable "efs_name" {}