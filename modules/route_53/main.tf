resource "aws_route53_zone" "its-testtask-node_fun" {
  #name = "its-testtask-node.fun"
   name = var.route_53_zone
}

resource "aws_route53_record" "its-testtask-node-fun-A" {
  zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
  #name    = "its-testtask-node.fun"
  name = var.route_53_zone
  type    = "A"
  alias {
          evaluate_target_health = true
          #name                   = aws_elb.load_balancer.dns_name 
          #name                   = aws_lb.application_load_balancer.dns_name
          name                   = var.elb_dns_name
          #zone_id                = aws_elb.load_balancer.zone_id
          #zone_id                = aws_lb.application_load_balancer.zone_id
          zone_id                = var.elb_zone_id
        }
}

#кажется, следующие 2 рекорда не нужно было создавать - они автоматически AWS-ом создаются при создании A type record-a

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
#   #name    = "its-testtask-node.fun"
#   name    = var.route_53_zone
#   ttl     = 172800
#   type    = "NS"
#   records = [
#     aws_route53_zone.its-testtask-node_fun.name_servers[0],
#     aws_route53_zone.its-testtask-node_fun.name_servers[1],
#     aws_route53_zone.its-testtask-node_fun.name_servers[2],
#     aws_route53_zone.its-testtask-node_fun.name_servers[3],
#   ]
# }

# resource "aws_route53_record" "its-testtask-node-fun-SOA" {
#   zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
#   #name    = "its-testtask-node.fun"
#   name    = var.route_53_zone
#   ttl     = 900
#   type    = "SOA"
#   records = [ "aws_route53_zone.its-testtask-node_fun.name_servers[2]. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
# }

