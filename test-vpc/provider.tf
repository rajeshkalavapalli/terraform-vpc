terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }

    backend "s3" {
    bucket = "vpc-p"
    key    = "vpc-1.1"
    region = "us-east-1"
    dynamodb_table = "new_t"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}