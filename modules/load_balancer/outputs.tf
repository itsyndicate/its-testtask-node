output "elb_zone_id" {
    value = aws_elb.load_balancer.zone_id
}

output "elb_dns_name" {
    value = aws_elb.load_balancer.dns_name
}