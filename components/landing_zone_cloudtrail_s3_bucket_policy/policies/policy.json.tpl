{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudTrailAclCheck20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "config.amazonaws.com",
                    "cloudtrail.amazonaws.com",
                    "billingreports.amazonaws.com"
                ]
            },
            "Action": [
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy"
            ],
            "Resource": "arn:aws:s3:::${s3_bucket_name}"
        },
        {
            "Sid": "CloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "config.amazonaws.com",
                    "cloudtrail.amazonaws.com"
                ]
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${s3_bucket_name}/AWSLogs/${account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Sid": "CloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "config.amazonaws.com",
                    "cloudtrail.amazonaws.com"
                ]
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${s3_bucket_name}/AWSLogs/o-64jt97y4nm/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Sid": "BillingReportsWrite20150319",
            "Effect": "Allow",
            "Principal": {
                "Service": "billingreports.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${s3_bucket_name}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
