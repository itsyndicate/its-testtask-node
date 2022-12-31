resource "aws_security_group" "demo-cluster" {
  #name        = "terraform-eks-demo-cluster"
  name        = var.security_group
  description = "Cluster communication with worker nodes"
  ###vpc_id      = aws_vpc.demo.id
  vpc_id      = var.vpc_id 
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.demo-cluster.id
  to_port           = 80
  type              = "ingress"
}

#
# Workstation External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local workstation to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.response_body)}/32"
}
