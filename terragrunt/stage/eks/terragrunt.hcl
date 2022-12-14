include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:negrych-vladyslav/its.git//eks"
}

inputs = {
    cluster_name = "its-eks"
    vpc_name = "its-vpc"
    vpc_cidr = "10.0.0.0/16"
    env_tag = "its-env"
    private_subnet_name = "its-private-subnet"
    public_subnet_name = "its-public-subnet"
    private_subnet = ["10.0.101.0/24", "10.0.102.0/24"]
    public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
    instance_type = ["t2.medium"]
    max_size = "4"
    min_size = "2"
    desired_size = "2"
    disk_size = "50"
}
