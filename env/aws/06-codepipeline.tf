//resource "aws_codepipeline" "codepipeline" {
//  name     = "${var.project_name}-pipeline"
//  role_arn = aws_iam_role.codepipeline_role.arn
//
//  artifact_store {
//    location = aws_s3_bucket.codepipeline_bucket.bucket
//    type     = "S3"
//  }
//
//  stage {
//    name = "Source"
//
//    action {
//      name             = "Source"
//      category         = "Source"
//      owner            = "ThirdParty"
//      provider         = "GitHub"
//      version          = "1"
//      output_artifacts = ["build_input"]
//
//      configuration = {
//        OAuthToken = data.external.oauth_token.result["OAUTH_TOKEN"]
//        Owner = "ivanpang1996"
//        Repo = "fhwuifhui"
//        Branch    = "master"
//      }
//    }
//  }
//
//  stage {
//    name = "Build"
//
//    action {
//      name             = "Build"
//      category         = "Build"
//      owner            = "AWS"
//      provider         = "CodeBuild"
//      version          = "1"
//      input_artifacts = ["build_input"]
//      output_artifacts = ["build_output"]
//
//      configuration = {
//        ProjectName = aws_codebuild_project.codebuild_project.name
//      }
//    }
//  }
//
//  stage {
//    name = "Deploy"
//
//    action {
//      name            = "Deploy"
//      category        = "Deploy"
//      owner           = "AWS"
//      provider        = "ECS"
//      version         = "1"
//      input_artifacts = ["build_output"]
//
//      configuration = {
//        "ClusterName": aws_ecs_cluster.url_shortener.name,
//        "ServiceName": "url-shortener",
//      }
//    }
//  }
//}
//
//
//
//resource "aws_iam_role" "codepipeline_role" {
//  name = "${var.project_name}-codepipeline-role"
//
//  assume_role_policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "codepipeline.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_role_policy" "codepipeline_policy" {
//  name = "${var.project_name}-codepipeline-policy"
//  role = aws_iam_role.codepipeline_role.id
//
//  policy = <<EOF
//{
//    "Statement": [
//        {
//            "Action": [
//                "iam:PassRole"
//            ],
//            "Resource": "*",
//            "Effect": "Allow",
//            "Condition": {
//                "StringEqualsIfExists": {
//                    "iam:PassedToService": [
//                        "cloudformation.amazonaws.com",
//                        "elasticbeanstalk.amazonaws.com",
//                        "ec2.amazonaws.com",
//                        "ecs-tasks.amazonaws.com"
//                    ]
//                }
//            }
//        },
//        {
//            "Action": [
//                "codecommit:CancelUploadArchive",
//                "codecommit:GetBranch",
//                "codecommit:GetCommit",
//                "codecommit:GetRepository",
//                "codecommit:GetUploadArchiveStatus",
//                "codecommit:UploadArchive"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "codedeploy:CreateDeployment",
//                "codedeploy:GetApplication",
//                "codedeploy:GetApplicationRevision",
//                "codedeploy:GetDeployment",
//                "codedeploy:GetDeploymentConfig",
//                "codedeploy:RegisterApplicationRevision"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "codestar-connections:UseConnection"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "elasticbeanstalk:*",
//                "ec2:*",
//                "elasticloadbalancing:*",
//                "autoscaling:*",
//                "cloudwatch:*",
//                "s3:*",
//                "sns:*",
//                "cloudformation:*",
//                "rds:*",
//                "sqs:*",
//                "ecs:*"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "lambda:InvokeFunction",
//                "lambda:ListFunctions"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "opsworks:CreateDeployment",
//                "opsworks:DescribeApps",
//                "opsworks:DescribeCommands",
//                "opsworks:DescribeDeployments",
//                "opsworks:DescribeInstances",
//                "opsworks:DescribeStacks",
//                "opsworks:UpdateApp",
//                "opsworks:UpdateStack"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "cloudformation:CreateStack",
//                "cloudformation:DeleteStack",
//                "cloudformation:DescribeStacks",
//                "cloudformation:UpdateStack",
//                "cloudformation:CreateChangeSet",
//                "cloudformation:DeleteChangeSet",
//                "cloudformation:DescribeChangeSet",
//                "cloudformation:ExecuteChangeSet",
//                "cloudformation:SetStackPolicy",
//                "cloudformation:ValidateTemplate"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Action": [
//                "codebuild:BatchGetBuilds",
//                "codebuild:StartBuild",
//                "codebuild:BatchGetBuildBatches",
//                "codebuild:StartBuildBatch"
//            ],
//            "Resource": "*",
//            "Effect": "Allow"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "devicefarm:ListProjects",
//                "devicefarm:ListDevicePools",
//                "devicefarm:GetRun",
//                "devicefarm:GetUpload",
//                "devicefarm:CreateUpload",
//                "devicefarm:ScheduleRun"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "servicecatalog:ListProvisioningArtifacts",
//                "servicecatalog:CreateProvisioningArtifact",
//                "servicecatalog:DescribeProvisioningArtifact",
//                "servicecatalog:DeleteProvisioningArtifact",
//                "servicecatalog:UpdateProduct"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "cloudformation:ValidateTemplate"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "ecr:DescribeImages"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "states:DescribeExecution",
//                "states:DescribeStateMachine",
//                "states:StartExecution"
//            ],
//            "Resource": "*"
//        },
//        {
//            "Effect": "Allow",
//            "Action": [
//                "appconfig:StartDeployment",
//                "appconfig:StopDeployment",
//                "appconfig:GetDeployment"
//            ],
//            "Resource": "*"
//        }
//    ],
//    "Version": "2012-10-17"
//}
//EOF
//}
//
//resource "aws_s3_bucket" "codepipeline_bucket" {
//  bucket = "${var.project_name}-codepipeline-bucket-v3"
//  acl    = "private"
//}
//
//# TODO: please run ../init/00-setup-secret.sh before "terraform apply"
//data "external" "oauth_token" {
//  program = [
//    "bash",
//    "-c",
//    "aws ssm get-parameter --name OAUTH_TOKEN | jq '{OAUTH_TOKEN: .Parameter.Value}'"]
//}
