//resource "aws_codepipeline" "codepipeline" {
//  name     = "url--pipeline"
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
//      owner            = "AWS"
//      provider         = "GitHub"
//      version          = "1"
//
//      configuration = {
//        ConnectionArn    = aws_codestarconnections_connection.github.arn
//        FullRepositoryId = "ivanpang1996/fhwuifhui"
//        BranchName       = "master"
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
//
//      configuration = {
//        ProjectName = "url_shortener-codebuild"
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
//
//      configuration = {
//        "cluster_name": aws_ecs_cluster.url_shortener.name,
//        "service_name": module.url_shortener_service.service_name,
//      }
//    }
//  }
//}
//
//resource "aws_codestarconnections_connection" "github" {
//  name          = "github-connection"
//  provider_type = "GitHub"
//}
//
//
//resource "aws_iam_role" "codepipeline_role" {
//  name = "test-role"
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
//  name = "codepipeline_policy"
//  role = aws_iam_role.codepipeline_role.id
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect":"Allow",
//      "Action": [
//        "s3:GetObject",
//        "s3:GetObjectVersion",
//        "s3:GetBucketVersioning",
//        "s3:PutObject"
//      ],
//      "Resource": [
//        "arn:aws:s3:::codepipeline-ap-east-1-*"
//      ]
//    },
//    {
//      "Effect": "Allow",
//      "Action": [
//        "codebuild:BatchGetBuilds",
//        "codebuild:StartBuild"
//      ],
//      "Resource": "*"
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_s3_bucket" "codepipeline_bucket" {
//  bucket = "${var.project_name}-codepipeline-bucket"
//  acl    = "private"
//}
