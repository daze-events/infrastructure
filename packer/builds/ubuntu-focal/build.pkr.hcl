build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file   = "../ansible/${var.env}.yml"
    extra_arguments = local.ansible_extra_arguments
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
    strip_time = true
  }
}
