terraform {
  backend "s3" {
    region  = "us-west-2"
    bucket  = "awx-terraform"
    key     = "terraform/awx/terraform.tfstate"
    encrypt = true
  }
}
