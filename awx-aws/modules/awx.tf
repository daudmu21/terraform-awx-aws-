

data "aws_ami" "centos-region1" {
  provider    = "aws.region1"
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
}


resource "aws_instance" "awx" {
  provider		      =	"aws.region1"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  ami                         = "${data.aws_ami.centos-region1.id}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_awx"]
  iam_instance_profile = "${aws_iam_instance_profile.tower_profile.name}"

  provisioner "file" {
    source      = "./modules/awx"
    destination = "/tmp/"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo yum install -y epel-release",
      "sudo yum install -y yum-utils device-mapper-persistent-data lvm2 ansible git python-devel python-pip python-docker-py vim-enhanced ",
      "sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum install  docker-ce -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo pip uninstall docker docker-py docker-compose",
      "sudo pip install docker-compose==1.9",
      "sudo ansible-playbook -i /tmp/awx/installer/inventory /tmp/awx/installer/install.yml -vv",
    ]
  }
  tags = {
    Name = "Tower"
  }  
}



resource "aws_security_group" "allow_ssh_and_awx" {
  provider	=	"aws.region1"
  name        = "allow_ssh_and_awx"
  description = "Allow SSH and awx"
  vpc_id      = "${var.region1_vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Creates key for region1  
resource "aws_key_pair" "ansible" {
  provider	=	"aws.region1"
  key_name   = "ansible"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
