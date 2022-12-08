# terraform { 
#     backend "s3" {
#         bucket = "task-tfstates"
#         key    = "task/terraform.tfstate"
#         region = "us-east-1"
#     }
# }

provider "aws"{
    region = var.aws_region
    profile = var.aws_profile
}

 provider "kubernetes" {
    host = data.aws_eks_cluster.task-eks.endpoint
    token = data.aws_eks_cluster_auth.task-eks.token 
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.task-eks.certificate_authority.0.data)
 }

 data "aws_eks_cluster" "task-eks" {
    name = module.eks.cluster_id
 }

 data "aws_eks_cluster_auth" "task-eks" {
    name = module.eks.cluster_id
 }

 data "aws_availability_zones" "azs" {}

