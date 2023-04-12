terraform {
  backend "s3" {
    bucket = "oraculi-terraform-states"
    key    = "komiser"
    region = "eu-central-1"
  }
}

provider "aws" {
  region  = var.region
}