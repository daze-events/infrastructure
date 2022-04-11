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

  ansible_extra_vars = flatten([for k, v in var.ansible_extra_vars : ["-e", "${k}=${v}"]])
  ansible_debug      = var.ansible_debug ? [for index in range(var.ansible_debug_level) : "-v"] : [""]

  ansible_extra_arguments = compact(concat(
    local.ansible_extra_vars,
    local.ansible_debug
  ))

}
