terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
    backend "s3" {
      bucket = "remote-state-bucket-aws"
      key = "10-vpc"
      region = "us-east-1"
      dynamodb_table = "remote-state-table"
    }
}
provider "aws" {
  region = "us-east-1"
}

