locals {
  vpc_id           = var.vpc_id
  subnet_id        = var.subnet_id
  ssh_user         = "ubuntu"

}

# Need to create a key-pair

resource "aws_key_pair" "my_key" {

  key_name   = "my-ec2-key"
  public_key = file("terra-key-ec2.pub")

}

# Need to create VPC & Security Group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sg" {
  
  name = "automate_sg"
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

    Name = "automatic sg"

  }
}
# Need to create ec2 instance

# Meta argument using count
/*
resource  "aws_instance" "my_instance" {

    count                   = 3 # Meta argument using count
    key_name                = aws_key_pair.my_key.key_name
    subnet_id               = local.subnet_id
    vpc_security_group_ids  = [aws_security_group.my_sg.id]
    instance_type           = var.ec2_instance_type
    ami                     = var.ec2_instance_ami_id # ubuntu
    user_data               = file ("install_nginx.sh")
    associate_public_ip_address = true

    root_block_device {
      volume_size = var.ec2_instance_storage
      volume_type = "gp3"
    }

    tags = {
        #Name = "ec2-automate-terra-${count.index}" # count.index gives you the 0-based index of each instance.

        Name = var.instance_name[count.index]
    }
    
}
*/


# Meta argument using for-each

resource  "aws_instance" "my_instance" {

    for_each = tomap({
        nikhil_automate_micro = "t2.micro"
        nikhil_automate_samll = "t2.small"
        # nikhil_automate_medium = "t2.medium"
    })
    

    # depends_on meta argument - for order
    depends_on = [ aws_security_group.my_sg, aws_key_pair.my_key ]

    key_name                = aws_key_pair.my_key.key_name
    subnet_id               = local.subnet_id
    vpc_security_group_ids  = [aws_security_group.my_sg.id]
    instance_type           = each.value
    ami                     = var.ec2_instance_ami_id # ubuntu
    user_data               = file ("install_nginx.sh")
    associate_public_ip_address = true

    root_block_device {
      volume_size = var.env == "prod" ? 20 : var.ec2_instance_deafault_storage
      volume_type = "gp3"
    }

    /*
    If your environment (var.env) is "prod",
    → Terraform will set the volume size to 20 GB.

    If not (like dev or stage),
    → It will use whatever value is stored in the variable var.ec2_instance_deafault_storage.
    */

    tags = {
        Name = each.key
    }
    
}

