variable "env" {
  description = <<EOF
  "
  Specifies which environment the AMI will be built for.
  "
  EOF
  type        = string
}

variable "ssh_public_keys" {
  description = <<EOF
  "
  A list of strings representing the SSH public keys to add to the image.
  Ansible will write the keys to the `authorized_keys` file in the `target_user`'s home..
  "
  EOF
  type        = list(string)
  default     = []
}

variable "ansible_target_user" {
  description = <<EOF
  "
  The user to setup when provisioning the instance. It should be different from the default AMI user for security reasons.
  If the user does not exist, it will be created and added to the sudoers group.
  "
  EOF
  type        = string
}

variable "ansible_debug" {
  description = <<EOF
  "

  "
  EOF
  type        = bool
  default     = false
}

variable "ansible_debug_level" {
  description = <<EOF
  "

  "
  EOF
  type        = number
  default     = 2
}

variable "ansible_extra_vars" {
  description = <<EOF
  "
  The type is not specified to allow any type of map to be passed in.
  "
  EOF
  default     = {}
}

variable "ami_source_release" {
  description = <<EOF
  "
  The version of Ubuntu to use when provisioning the AMI.
  The format should be <adjective>-<version> as documented
  here: https://wiki.ubuntu.com/DevelopmentCodeNames
  "
  EOF
  type        = string
  default     = "focal-20.04"
}

variable "ami_target_prefix" {
  description = <<EOF
  "
  A string prefix for the target AMI name.
  "
  EOF
  type        = string
}

variable "ami_target_name" {
  description = <<EOF
  "
  A string suffix for the AMI name. It is preceded by the `ami_target_prefix`.
  "
  EOF
  type        = string
}

variable "ami_description" {
  description = <<EOF
  "
  The description to associate to the target AMI.
  "
  EOF
  type        = string
  default     = ""
}

variable "instance_type" {
  description = <<EOF
  "
  Instance sizing used during AMI provisioning.
  "
  EOF
  type        = string
  default     = "t3a.small"
}

variable "create_ami" {
  description = <<EOF
  "
  Whether to create the target AMI after the provisioning
  process finishes. Set to `true` during testing.
  "
  EOF
  type        = bool
  default     = true
}

variable "additional_account_ids" {
  description = <<EOF
  "
  List of AWS Account ID's allowed to access the AMI.
  "
  EOF
  type        = list(string)
  default     = [""]
}

variable "tags" {
  description = <<EOF
  "

  "
  EOF
  type        = map(string)
  default     = {}
}
