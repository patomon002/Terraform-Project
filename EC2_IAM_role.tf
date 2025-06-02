# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "5.39.0"
#     }
#   }
# }
 
# provider "aws" {
#   # Configuration options
#   region = "us-east-1"
# }


 #Metrics for memory and disk utilization
#  #This metrics should be stored on AWS System manager - SSM

#  {
# 	"metrics": {
# 		"append_dimensions": {
# 			"InstanceId": "${aws:InstanceId}"
# 		},
# 		"metrics_collected": {
# 			"mem": {
# 				"measurement": [
# 					"mem_used_percent"
# 				],
# 				"metrics_collection_interval": 60
# 			},
#             "disk": {
# 				"measurement": [
#                      "disk_used_percent"
# 				],
# 				"metrics_collection_interval": 60
# 			}
# 		}
# 	}
# }


#create IAM role


# data "aws_iam_policy_document" "instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ec2_role" {
#   name = "ec2_role"
#   path = "/"
#   assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
# }


# resource "aws_iam_role_policy" "CW_policy" {
#   name = "CW_policy"
#   role = "${aws_iam_role.ec2_role.id}"
#   policy = "${file("cloudwatch_policy.json")}"

# }
# resource "aws_iam_role_policy" "SSM_policy" {
#   name = "SSM_policy"
#   role = "${aws_iam_role.ec2_role.id}"
#   policy = "${file("SSM_policy.json")}"

# }


# resource "aws_iam_instance_profile" "EC2_profile" {
#   name = "EC2_profile"
#   role =   "${aws_iam_role.ec2_role.id}"
# }

