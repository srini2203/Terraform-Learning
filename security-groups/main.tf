resource "aws_vpc" "main"{
    cidr_block="10.0.0.0/16"
}

resource "aws_security_group" "app"{
    vpc_id=aws_vpc.main.id

ingress{
    from_port=80
    to_port=80
    protocol="TCP"
    cidr_blocks=["0.0.0.0/0"]
}

egress{
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
}
}
