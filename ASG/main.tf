resource "aws_launch_template" "app"{
    image_id="ami-"
    vpc_security_group_ids=[
        aws_security_group.id
    ]
    instance_type="t3.micro"
    tag_specifications{
        resource_type="instance"
        tags={
            Name="lab12-lt"
        }
    }
}

resource "aws_auto_scaling_group" "app1"{
    name="lab12-asg"
    launch_template{
            id=aws_launch_template.app.id
            version="$Latest"
    }
    min_size=1
    max_size=2
    desired_capacity=1
    vpc_zone_identifier=[
        aws_subnet.public1A.id,
        aws_subnet.public1B.id
    ]
}