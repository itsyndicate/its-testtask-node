output "route_53_zone_id" {
    value = aws_route53_zone.its-testtask-node_fun.zone_id
}

output "route_53_zone" {
     value = var.route_53_zone
}
