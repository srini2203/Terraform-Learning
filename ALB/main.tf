resource "aws_vpc" "main"{
    cidr_block="10.0.0.0/16"

    tags={
        Name="module-10-vpc"
    }
}
#Subnet

resource "aws_subnet" "public1A"{
    vpc_id=aws_vpc.main.id
    cidr_block="10.0.1.0/24"
    availability_zone="ap-south-1a"
    map_public_ip_on_launch=true

    tags={
        Name="lab-10-1a"
    }
}

resource "aws_subnet" "public1B"{
    vpc_id=aws_vpc.main.id
    cidr_block="10.0.2.0/24"
    availability_zone="ap-south-1b"
    map_public_ip_on_launch=true

    tags={
        Name="lab-10-1b"
}
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-lab-10-igw"
  }
}

resource "aws_route_table" "public"{
    vpc_id=aws_vpc.main.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.main.id
    }
    tags={
        Name="lab10-public-rt"
    }
}

resource "aws_route_table_association" "public_1"{
    subnet_id=aws_subnet.public1A.id
    route_table_id=aws_route_table.public.id
}

resource "aws_route_table_association" "public_2"{
    subnet_id=aws_subnet.public2A.id
    route_table_id=aws_route_table.public.id
}

resource "aws_security_group" "alb"{
    name="lab10-sg"
    vpc_id=aws_vpc.main.id

    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }

    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
    }
}

resource "aws_lb" "app"{
    name="alb-lab10"
    internal=false
    load_balancer_type="application"

    security_groups=[
        aws_security_group.alb.id
    ]
    subnets=[
        aws_subnet.public1A.id,
        aws_subnet.public1B.id
    ]
}

resource "aws_lb_target_group" "app"{
    vpc_id=aws_vpc.main.id
    protocol="HTTP"
    port=80
    name="lab10-tg"
    health_check{
        path="/"
    }
}

resource "aws_lb_listener" "http"{
    load_balancer_arn=aws_lb.app.arn
    port=80
    protocol="HTTP"

    default_action{
        type="forward"
        target_group_arn=aws_lb_target_group.app.arn
    }
}