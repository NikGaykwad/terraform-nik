# used for type for normal or count 
/*
variable "ec2_instance_type"{
    default = "t2.micro"
    type = string
}
*/
variable "ec2_instance_deafault_storage"{
    default = 10
    type = number
}

variable "ec2_instance_ami_id"{
    default = "ami-02d26659fd82cf299"
    type = string
}

variable "vpc_id"{
    default = "vpc-06111e9cc534c08dd"
    type = string
}

variable "subnet_id"{
    default = "subnet-0a22881121917e35e"
    type = string
}

variable "env"{
    default = "prod"
    type = string
}

# used for count with different names
/*
variable "instance_name" {
  default = ["web", "app", "db"]
}
*/