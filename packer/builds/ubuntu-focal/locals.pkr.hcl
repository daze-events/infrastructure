locals {
  ami_name = format(
    "%s-%s-%s",
    var.ami_target_prefix,
    "ubuntu",
    var.ami_target_name,
  )

  ami_description = format(
    "%s Source AMI: ubuntu-%s | %s",
    var.ami_description,
    var.ami_source_release,
    formatdate("EEEE-DD-MMM-YY-hh-mm-ss-ZZZ", timestamp()),
  )

  ansible_main_directory_path      = "../ansible"
  ansible_playbooks_directory_path = "${local.ansible_main_directory_path}/playbooks"

  ansible_debug = var.ansible_debug ? [for index in range(var.ansible_debug_level) : "-v"] : [""]
}
