# Ansible vars
# ansible_target_user = "daze"
ansible_extra_vars = {
  target_user = "daze"
  foo         = "bar"
}
ansible_debug = true

# Packer vars
ami_target_name = "main"
ami_description = "Ubuntu AMI for Development environment."

create_ami = false

tags = {
  App = "Daze"
}
