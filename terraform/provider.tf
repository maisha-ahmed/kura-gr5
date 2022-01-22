terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Deployment = "Final Project"
      Team       = "Group 5"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-grp5"
    key    = "dev/iventorize-state"
    region = "us-east-1"
    encrypt = true
  }
}