resource "aws_instance" "worker1" {
  provider		      = "aws.region1"   
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  ami                         = "${data.aws_ami.centos-region1.id}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_awx"]
  

  provisioner "file" {
    source      = "/root/.ssh"
    destination = "/tmp/"

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }
  }
  

  provisioner "file" {
    source      = "./modules/ansible"
    destination = "/tmp/ansible"

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
      "sudo useradd -G wheel,docker ansible", 
 

      "# These commands below used for disabling host key verification",
      "sudo cp -f /tmp/.ssh/id_rsa.pub /tmp/.ssh/authorized_keys  &> /dev/null",
      "sudo cp -r /tmp/.ssh /home/ansible/ &> /dev/null",
      "sudo chmod 600 /home/ansible/.ssh/authorized_keys",
      "sudo chown -R ansible:ansible /home/ansible/",
      "sudo chmod 0600 /home/ansible/.ssh/id_rsa",       
      "sudo cp /tmp/ansible /etc/sudoers.d/", 
      "sudo chmod 440 /etc/sudoers.d/ansible",
     
    ]
  }
}
## Uses the same sec group as the tower
## Uses the same key as master
