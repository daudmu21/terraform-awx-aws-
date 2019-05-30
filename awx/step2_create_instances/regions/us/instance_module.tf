provider "aws" {
  region = "${var.region}"
}

data "template_file" "init" {
  template = "${file("${path.module}/userdata")}"
}

module "centos" {
  name                = "centos"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "centos"
  image_id            = "${var.ami_centos}"
  instance_type       = "${var.instance_type_centos}"
  min_size            = "${var.min_size_centos}"
  max_size            = "${var.max_size_centos}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
  key_name            = "${var.key_name}"
  security_groups     = ["${aws_security_group.allow_ssh_and_httpd_rdp.id}"]
}

module "ubuntu" {
  name                = "ubuntu"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "ubuntu"
  image_id            = "${var.ami_ubuntu}"
  instance_type       = "${var.instance_type_ubuntu}"
  min_size            = "${var.min_size_ubuntu}"
  max_size            = "${var.max_size_ubuntu}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
  key_name            = "${var.key_name}"
  security_groups     = ["${aws_security_group.allow_ssh_and_httpd_rdp.id}"]
  user_data           = "${data.template_file.init.rendered}"
}

module "debian" {
  name                = "debian"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "debian"
  image_id            = "${var.ami_debian}"
  instance_type       = "${var.instance_type_debian}"
  min_size            = "${var.min_size_debian}"
  max_size            = "${var.max_size_debian}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
  key_name            = "${var.key_name}"
  security_groups     = ["${aws_security_group.allow_ssh_and_httpd_rdp.id}"]
}

module "windows" {
  name                = "windows"
  source              = "terraform-aws-modules/autoscaling/aws"
  lc_name             = "windows"
  image_id            = "${var.ami_windows}"
  instance_type       = "${var.instance_type_windows}"
  min_size            = "${var.min_size_windows}"
  max_size            = "${var.max_size_windows}"
  desired_capacity    = "2"
  vpc_zone_identifier = ["${var.subnet}"]
  health_check_type   = "EC2"
  key_name            = "${var.key_name}"
  security_groups     = ["${aws_security_group.allow_ssh_and_httpd_rdp.id}"]
}
