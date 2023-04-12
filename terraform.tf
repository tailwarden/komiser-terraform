terraform {
  backend "s3" {
    bucket = "YOUR BUCKET"
    key    = "komiser"
    region = "YOUR REGION"
  }
}

provider "aws" {
  region = var.region
}
