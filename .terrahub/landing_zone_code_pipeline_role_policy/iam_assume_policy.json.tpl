{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "s3:GetBucketVersioning"
      ],
      Resource: [
        "${s3_bucket_arn}"
        "${artifact_s3_bucket_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion"
      ],
      Resource: [
        "${s3_bucket_arn}"
        "${artifact_s3_bucket_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:DeleteParameter",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
      ],
      Resource: "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuilds"
      ],
      Resource: [
        "${code_build_arn}"
        "${launch_avm_code_build_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:UploadArchive",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:CancelUploadArchive"
      ],
      Resource: "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "lambda:ListFunctions",
          "lambda:ListVersionsByFunction"
      ],
      Resource: "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "lambda:InvokeFunction"
      ],
      Resource: "${lambda_arn}"
    }    
  ]
}
