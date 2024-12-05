terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.79.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  #access_key = var.key_access
  #secret_key = var.key_secret
}