terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }

  backend "s3" {
    bucket = "remote-state-bucket-aws"
    key    = "80-ecr"
    region = "us-east-1"
    dynamodb_table = "81s-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}