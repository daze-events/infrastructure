packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_base_name" {
  type    = string
  default = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
}

variable "ami_target_name" {
  type    = string
  default = "dz-dev-ubuntu-focal-20.04"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

data "amazon-ami" "ubuntu_focal" {
  filters = {
    virtualization-type = "hvm"
    name                = var.ami_base_name
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
}

source "amazon-ebs" "ubuntu" {
  ami_name        = "${var.ami_target_name}"
  ami_description = "Ubuntu AMI for Development environment."

  instance_type = "${var.instance_type}"

  source_ami = data.amazon-ami.ubuntu_focal.id

  # VPC Filter
  vpc_filter {
    filters = {
      "tag:Name" : "dev-core*",
      "isDefault" : "false",
    }
  }

  # Subnet filter
  subnet_filter {
    filters = {
      "tag:Name" : "dev-core-public-*"
    }
    most_free = true
    random    = true
  }

  associate_public_ip_address = true
  shutdown_behavior           = "terminate"
  skip_create_ami             = true # Set to true during testing

  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file   = "./setup.yml"
    extra_arguments = ["-vvv"]
  }
}
