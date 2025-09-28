# Need to have the OS installed
# You will have set up a non root user during the install
# Ansible needs python already installed (pkg install python)
# Basic networking must be setup, so you packages can be fetched
# SSH, with keys, needs to be set up, so ansible can connect.
#
default: run

check:
	ansible-playbook --check -i inventory playbook.yml

run:
	ansible-playbook -i inventory playbook.yml
