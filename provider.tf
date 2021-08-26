
provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
  profile = "terraform"
}


terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-sg"
    key            = "daddyzi/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "eks-terraform-state-sg"
  }
}

