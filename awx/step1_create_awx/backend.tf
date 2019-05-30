terraform {
  backend "s3" {
    region  = "us-west-2"
    bucket  = "awx-terraform"
    key     = "terraform/awx-step1/terraform.tfstate"
    encrypt = true
  }
}
