provider "aws" {
  region = "${var.region1}"
}
provider "aws" {
  alias = "region1"
  region = "${var.region1}"
}
provider "aws" {
  alias = "region2"
  region = "${var.region2}"
}
provider "aws" {
  alias = "region3"
  region = "${var.region3}"
}
