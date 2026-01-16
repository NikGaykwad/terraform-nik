locals {
  vpc_id           = var.vpc_id
  subnet_id        = var.subnet_id
  ssh_user         = "ubuntu"

}

# Need to create a key-pair

resource "aws_key_pair" "my_key" {

  key_name   = "${var.env}-my-ec2-key"
  public_key = file("terra-key-ec2.pub")

    tags = {
      Environment = var.env
    }
}

# Need to create VPC & Security Group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sg" {
  
  name = "${var.env}-infra-app-sg"
  description = "This will add TF genrated security group"
  vpc_id = aws_default_vpc.default.id # interpolation

  # inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "SSH port 22 is open"

    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP port 80 is open"
    }

  # outbound rules

  egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All access open outbound"

  }

  tags = {

    Name = "${var.env}-infra-app-sg"

  }
}
# Need to create ec2 instance

resource  "aws_instance" "my_instance" {

    count                   = var.instance_count # Meta argument using count
    key_name                = aws_key_pair.my_key.key_name
    subnet_id               = local.subnet_id
    vpc_security_group_ids  = [aws_security_group.my_sg.id]
    instance_type           = var.ec2_instance_type
    ami                     = var.ec2_instance_ami_id # ubuntu
    associate_public_ip_address = true

    root_block_device {
      volume_size = var.env == "prod" ? 20 : 10
      volume_type = "gp3"
    }

    tags = {
    Name        = "${var.env}-infra-app-instance-${count.index+1}"
    Environment = var.env
}
    
}


