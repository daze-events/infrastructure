# https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md
config {
  plugin_dir = "~/.tflint.d/plugins"

  module              = true
  force               = false
  disabled_by_default = false
}

# https://github.com/terraform-linters/tflint-ruleset-aws#installation
plugin "aws" {
  enabled = true
  version = "0.12.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
