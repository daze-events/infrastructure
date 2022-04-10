locals {
  ami_name = format(
    "%s-%s-%s",
    var.ami_target_prefix,
    "ubuntu",
    var.ami_target_name
  )

  ami_description = format(
    "%s Source AMI: ubuntu-%s",
    var.ami_description,
    var.ami_source_release
  )
}
