variable "key_name" {
  description = <<EOF
  "

  "
  EOF
  type        = string
}

variable "key_name_prefix" {
  description = <<EOF
  "

  "
  EOF
  default     = null
  type        = string
}

variable "public_key" {
  description = <<EOF
  "

  "
  EOF
  type        = string
}

variable "tags" {
  description = <<EOF
  "

  "
  EOF
  default     = {}
  type        = map(string)
}

variable "tags_all" {
  description = <<EOF
  "

  "
  EOF
  default     = {}
  type        = map(string)
}
