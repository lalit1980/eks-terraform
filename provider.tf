terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}
provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "/Users/lalit/.aws/credentials"
  profile                 = "terraform"
}
terraform {
  backend "s3" {
    bucket                  = "eks-terraform-state-zatamap"
    key                     = "zatamap/dev/terraform.tfstate"
    region                  = "ap-south-1"
    dynamodb_table          = "eks-terraform-state-zatamap"
    shared_credentials_file = "/Users/lalit/.aws/credentials"
    profile                 = "terraform"
  }
}

