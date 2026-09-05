variable "aws_region"{
    type=string
    default="ap-south-1"
}

variable "instance_type"{
    type=string
    default="t3.micro"
}

variable "environment"{
    type=string
    default="Dev"
}

variable "instance_name"{
    type=string
    default="terraform-lab-03"
}

variable "cidr_block"{
    type=string
    default="10.0.0.0/16"
}