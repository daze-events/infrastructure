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

  snapshot_tags = {
    Name = local.ami_name
  }

  # Used in dev environment to easily overwrite a previous image
  # If "var.create_ami = false" we don't want to deregister the
  # latest AMI.
  force_deregister       = var.create_ami
  force_delete_snapshot  = var.create_ami
  skip_save_build_region = !var.create_ami

  encrypt_boot = true
  kms_key_id   = "f6d5d186-c207-45b2-9979-2d3e643594ab"

  # VPC Filter
  vpc_filter {
    filters = {
      "tag:Name" : "shared-build*",
      "isDefault" : "false",
    }
  }

  # Subnet filter
  subnet_filter {
    filters = {
      "tag:Name" : "*public*"
    }
    most_free = true
    random    = true
  }

  associate_public_ip_address = true
  shutdown_behavior           = "terminate"
  skip_create_ami             = !var.create_ami

  user_data = templatefile("./files/userdata.tpl", { ansible_ssh_user = var.ansible_ssh_user })

  ssh_username         = "ansible"
  ssh_keypair_name     = "shared-build-packer"
  ssh_private_key_file = pathexpand("~/.ssh/ssh_daze_events")

  tags = merge({
    Environment = var.env
    Source_AMI = var.ami_source_release },
    var.tags
  )
}
