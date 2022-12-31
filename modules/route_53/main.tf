resource "aws_route53_zone" "its-testtask-node_fun" {
   name = var.route_53_zone
}

resource "aws_route53_record" "its-testtask-node-fun-A" {
  zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
  name = var.route_53_zone
  type    = "A"
  alias {
          evaluate_target_health = true
          name                   = var.elb_dns_name
          zone_id                = var.elb_zone_id
        }
}


 resource "aws_route53_record" "www" {
   zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
   name    = var.route_53_zone
   ttl     = 172800
   type    = "NS"
   records = [
     aws_route53_zone.its-testtask-node_fun.name_servers[0],
     aws_route53_zone.its-testtask-node_fun.name_servers[1],
     aws_route53_zone.its-testtask-node_fun.name_servers[2],
     aws_route53_zone.its-testtask-node_fun.name_servers[3],
   ]
 }

 resource "aws_route53_record" "its-testtask-node-fun-SOA" {
   zone_id = aws_route53_zone.its-testtask-node_fun.zone_id
   name    = var.route_53_zone
   ttl     = 900
   type    = "SOA"
   records = [ "aws_route53_zone.its-testtask-node_fun.name_servers[2]. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
 }

