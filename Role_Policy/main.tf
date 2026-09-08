resource "aws_iam_role" "app"{
    name="terraform-lab-07"

    assume_role_policy=jsonencode({
        Version="2012-10-17"
        Statement=[{
        Effect="Allow"
        Principal={
             Service="ec2.amazonaws.com"
        }
        Action="sts:AssumeRole"
    }]
    })
}

resource "aws_iam_policy" "app"{
    name="terrafor-lab07-02"

    policy=jsonencode({
        Version="2012-10-17"

        Statement=[{
            Effect="Allow"
            Action=[
                "s3:GetObject"
            ]
            Resource="*"

        }]
    })
}

resource "aws_iam_role_policy_attachment" "app"{
    role="aws_iam_role.app.name"
    policy_arn="aws_iam_policy.app.name"
}