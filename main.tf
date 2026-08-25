resource "aws_instance" "main"{
    instance_type="t3.micro"
    ami="ami-0ac7b260cf76d8865"
    tags={
        Name="terraform-lab-01"
    }
}