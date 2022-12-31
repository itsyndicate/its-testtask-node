output "vpc_id" {
    value = aws_vpc.demo.id
}
  
output "region" {
    value = var.region
}

output "cluster-name" {
    value = var.cluster-name
}

output "subnet_ids" {
    value = aws_subnet.demo[*].id
}