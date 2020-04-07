terraform {
backend "s3" {
bucket = "terraform-test-2020"
key = "tower/us-east-1/tools/tools/tower.tfstate"
region = "us-east-1"
  }
}
