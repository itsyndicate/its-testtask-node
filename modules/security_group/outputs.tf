output "security_group" {
    value = var.security_group
}

output "vpc_id" {
    value = var.vpc_id
}

output "security_group_ids" {
    value = aws_security_group.demo-cluster.id
}