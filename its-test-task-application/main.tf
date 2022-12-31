provider "aws" {
  region = var.region
  access_key = "AKIAQYHYC4F4FNLRD7HG"
  secret_key = "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"
}

module "eks_cluster" {
    source            = "../modules/eks_cluster"
    security_group_ids = module.security_group.security_group_ids
    subnet_ids        = module.vpc.subnet_ids
    cluster-name      = var.cluster-name   
}

module "eks_node_group" {
    source            = "../modules/eks_node_group"
    subnet_ids        = module.vpc.subnet_ids
    cluster-name      = var.cluster-name 
    node_group_name   = var.node_group_name
}

module "vpc" {
    source         = "../modules/vpc"
    region         = var.region
    vpc_cidr       = var.vpc_cidr  
    cluster-name   = var.cluster-name
}

module "security_group" {
    source         = "../modules/security_group"
    security_group = var.security_group
    vpc_id         = module.vpc.vpc_id
}

module "route_53" {
    source           = "../modules/route_53"
    route_53_zone    = var.route_53_zone
    elb_zone_id      = module.load_balancer.elb_zone_id
    elb_dns_name     = module.load_balancer.elb_dns_name
 }

module "load_balancer" {
    source           = "../modules/load_balancer"
}

