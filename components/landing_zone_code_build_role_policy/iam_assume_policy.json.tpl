{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:${region}:${account_id}:log-group:/aws/codebuild/*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:DeleteObject"
      ],
      "Resource": "${artifact_s3_bucket_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
          "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::solutions-reference/*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "ssm:GetParameter",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
      ],
      "Resource": "*"
    }     
  ]
}
