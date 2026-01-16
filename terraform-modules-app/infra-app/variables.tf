
variable "ec2_instance_type"{
    description = "This is the insance type of ec2 for my infra"
    type = string
}

variable "ec2_instance_ami_id"{
    description = "This is the ami id of ec2 for my infra"
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

variable "instance_count"{
    description = "This is the number of ec2 for my infra"
    type = number
}

variable "env"{
    description = "This is the env for my infra"
    type = string
}

variable "bucket-name"{
    description = "This is the name of s3 bucket for my infra"
    type = string
}

variable "hash-key"{
    description = "This is the hash-key of dynamodb for my infra"
    type = string
}
