terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kind = {
      source  = "kyma-incubator/kind"
      version = "0.0.9"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}
provider "aws" {
  region  = "ap-southeast-1"
  shared_credentials_file = "/Users/lalit/.aws/credentials"
  profile = "terraform"
}
terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-daddyzi"
    key            = "daddyzi/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "eks-terraform-state-daddyzi"
    shared_credentials_file = "/Users/lalit/.aws/credentials"
    profile = "terraform"
  }
}

