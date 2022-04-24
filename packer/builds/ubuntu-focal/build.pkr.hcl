build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "./ansible/common.yml"
    extra_arguments = compact(concat([
      "-e", "target_user=${jsonencode(var.ansible_target_user)}",
      "-e", "ssh_public_keys=${jsonencode(var.ssh_public_keys)}",
      "-u", "${var.ansible_ssh_user}",
    ], local.ansible_debug))
  }

  provisioner "ansible" {
    playbook_file = "./ansible/${var.env}.yml"
    extra_arguments = compact(concat([
      "-e", "target_user=${jsonencode(var.ansible_target_user)}",
      "-u", "${var.ansible_target_user}",
    ], local.ansible_debug))
  }
}
