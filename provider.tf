terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region  = "ap-southeast-1"
  profile = "terraform"
}
terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-daddyzi"
    key            = "daddyzi/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "eks-terraform-state-daddyzi"
  }
}

