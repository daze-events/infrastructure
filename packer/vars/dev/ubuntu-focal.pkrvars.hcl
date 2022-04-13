# Ansible vars
ansible_target_user = "daze"
ansible_extra_vars  = {}
# ansible_debug       = true
# ansible_debug_level = 3

additional_account_ids = [
  "844769057455", # Development account
]

# Packer vars
ami_target_name = "main"
ami_description = "Ubuntu AMI for Development environment."

create_ami = true

tags = {
  App = "Daze"
}
