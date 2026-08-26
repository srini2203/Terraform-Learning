terraform {
    required_providers{
        aws={
            source="hashicorp/aws"
            version= "~> 6.0"
        }
    }
}

provider "aws"{
    region="ap-south-1"
}

resource "aws_instance" "main"{
    instance_type="t3.micro"
    ami="ami-0ac7b260cf76d8865"

    tags = {
        Name="terraform-lab-02"
    }
}