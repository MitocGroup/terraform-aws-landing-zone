{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": "*"
        },
        {
            "Sid": "",
            "Effect": "Deny",
            "Action": [
                "iam:Upload*",
                "iam:Update*",
                "iam:Reset*",
                "iam:Remove*",
                "iam:Put*",
                "iam:Detach",
                "iam:Delete*",
                "iam:Create*",
                "iam:Attach*",
                "iam:Add*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "",
            "Effect": "Deny",
            "Action": [
                "ec2:UpdateSecurityGroup*",
                "ec2:RevokeSecurityGroup*",
                "ec2:DeleteSecurityGroup",
                "ec2:CreateSecurityGroup",
                "ec2:AuthorizeSecurityGroup*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "",
            "Effect": "Deny",
            "Action": [
                "ec2:RejectVpc*",
                "ec2:ModifyVpc*",
                "ec2:DisassociateVpc*",
                "ec2:DeleteVpc*",
                "ec2:CreateVpc*",
                "ec2:AssociateVpc*",
                "ec2:AcceptVpc*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "",
            "Effect": "Deny",
            "Action": [
                "ec2:ReplaceNetwork*",
                "ec2:ModifySubnet*",
                "ec2:ModifyRoute*",
                "ec2:DisassociateSubnet*",
                "ec2:DisassociateRoute*",
                "ec2:DeleteSubnet*",
                "ec2:DeleteRoute*",
                "ec2:DeleteNetwork*",
                "ec2:CreateSubnet*",
                "ec2:CreateRoute*",
                "ec2:CreateNetwork*",
                "ec2:AssociateSubnet*",
                "ec2:AssociateRoute*"
            ],
            "Resource": "*"
        }
    ]
}
