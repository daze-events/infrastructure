build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "../ansible/${var.env}.yml"
    extra_arguments = [
      "-e",
      "target_user=${var.ansible_target_user}",
    ]
  }
}
