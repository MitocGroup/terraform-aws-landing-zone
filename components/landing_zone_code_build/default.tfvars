landing_zone_providers = [
  "default"
]

landing_zone_code_build_name                     = "AWS-Landing-Zone-CodeBuild"
landing_zone_code_build_artifacts_type           = "CODEPIPELINE"
landing_zone_code_build_source_type              = "CODEPIPELINE"
landing_zone_code_build_environment_compute_type = "BUILD_GENERAL1_SMALL"
landing_zone_code_build_environment_image        = "aws/codebuild/nodejs:8.11.0"
landing_zone_code_build_environment_type         = "LINUX_CONTAINER"
