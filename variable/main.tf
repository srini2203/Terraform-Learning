resource "aws_instance" "main"{
        ami="ami-0ac7b260cf76d8865"
        instance_type=var.instance_type

        tags={
            Name=var.instance_name
            Environment=var.environment
        }
}