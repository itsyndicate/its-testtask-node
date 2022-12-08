#This file can optionally be used to build and to push image

provider "aws"{
    region = "us-east-1"
}


resource "aws_vpc" "task-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name: "task-vpc"
    }
}

resource "aws_subnet" "task-subnet-1" {
    vpc_id = aws_vpc.task-vpc.id
    cidr_block = "10.0.100.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name: "task-subnet-1"
    }
}

resource "aws_route_table" "task-route-table" {
    vpc_id = aws_vpc.task-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.task-igw.id
    }
    tags = {
        Name = "task-rtb"
    }
}

resource "aws_internet_gateway" "task-igw" {
    vpc_id = aws_vpc.task-vpc.id
    tags = {
        Name = "task-igw"
    }
}


resource "aws_route_table_association" "rtb-ass" {
     subnet_id = aws_subnet.task-subnet-1.id
     route_table_id = aws_route_table.task-route-table.id
}

resource "aws_security_group" "task-sg" {
    name = "task-sg"
    vpc_id = aws_vpc.task-vpc.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
        Name = "task-sg"
    }
}

resource "aws_key_pair" "mykey"  {
            key_name = "mykeytest"
            public_key = file("/Users/mac/.ssh/id_rsa.pub")
        }

data "aws_ami" "aws_ami" {
    most_recent = "true"
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

output "aws_ami_id_output" {
  value       = data.aws_ami.aws_ami.id
}

#resource "aws_key_pair" "task_kp" {
#    key_name = "task_kp"
#    public_key =  "/Users/mac/.ssh/id_rsa.pub"
#}

resource "aws_spot_instance_request" "task-instance" {
  ami                    = data.aws_ami.aws_ami.id
  spot_price             = "0.016"
  instance_type          = "t3.small"
  spot_type              = "one-time"
#  block_duration_minutes = "120"
  wait_for_fulfillment   = "true"
  key_name               = aws_key_pair.mykey.key_name
  associate_public_ip_address = true

  security_groups = [aws_security_group.task-sg.id]
  subnet_id = aws_subnet.task-subnet-1.id
}


#data "aws_instance" "instance_ip" {
#    instance_id = aws_instance.task-instance.id
#}

#output "instance_ip-out" {
#    value = data.aws_instance.instance_ip.public_ip
#}


resource "null_resource" "ansible_play" {
    triggers = {
       trigger = aws_spot_instance_request.task-instance.public_ip
    }

    provisioner "local-exec" {
#       working_dir = ""
       command = "ansible-playbook --inventory ${aws_spot_instance_request.task-instance.public_ip}, --private-key /Users/mac/.ssh/id_rsa buildpush.yml" 
    }
}
