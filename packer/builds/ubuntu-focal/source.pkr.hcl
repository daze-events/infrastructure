data "amazon-ami" "ubuntu_focal" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/*ubuntu-${var.ami_source_release}-amd64-server-*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
}

source "amazon-ebs" "ubuntu" {
  source_ami      = data.amazon-ami.ubuntu_focal.id
  ami_name        = local.ami_name
  ami_description = local.ami_description
  instance_type   = var.instance_type

  ami_users = var.additional_account_ids

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
  skip_create_ami             = !var.create_ami

  ssh_username = "ubuntu"
}
