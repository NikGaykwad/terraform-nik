terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.18.0"
    }
  }


  backend "s3" {
  bucket        = "my-state-bucket-nikhil-2025"
  key           = "terraform.tfstate"
  region        = "ap-south-1"
  use_lockfile  = true
}

}

