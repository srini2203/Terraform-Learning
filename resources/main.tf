resource "aws_vpc" "main"{
    cidr_block=var.vpc_cidr
}

resource "aws_subnet" "sub"{
    cidr_block="10.0.1.0/24"
    vpc_id=aws_vpc.main.id
}

resource "aws_instance" "app"{
    ami="ami-0ac7b260cf76d8865"
    instance_type="t3.micro"
}