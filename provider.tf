# Required version to be set.
terraform {
  required_version = "<= 3.3.14" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "newly-terraform-tfvars"
    key    = "newlyterraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}
