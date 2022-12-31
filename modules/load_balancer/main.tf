resource "aws_elb" "load_balancer" {
  cross_zone_load_balancing   = false
  availability_zones = ["us-east-1a", "us-east-1b"]
  listener {
    instance_port     = 31905
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }
  tags                        = {
     "kubernetes.io/cluster/EKS-cluster-test" = "owned"
     "kubernetes.io/service-name"             = "default/flask-app"
        }
  tags_all                    = {
     "kubernetes.io/cluster/EKS-cluster-test" = "owned"
     "kubernetes.io/service-name"             = "default/flask-app"
  }
}

