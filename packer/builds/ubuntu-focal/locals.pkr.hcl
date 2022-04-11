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

  ansible_target_user = {
    "target_user" = var.ansible_target_user
  }

  ssh_public_keys = {
    "ssh_public_keys" = var.ssh_public_keys
  }

  ansible_extra_vars = flatten([for k, v in merge(
    var.ansible_extra_vars,
    local.ansible_target_user,
    local.ssh_public_keys
  ) : ["-e", "${k}=${jsonencode(v)}"]])
  ansible_debug = var.ansible_debug ? [for index in range(var.ansible_debug_level) : "-v"] : [""]

  ansible_extra_arguments = compact(concat(
    local.ansible_extra_vars,
    local.ansible_debug
  ))

}
