# Need to have the OS installed
# You will have set up a non root user during the install
# Ansible needs python already installed (pkg install python)
# Basic networking must be setup, so you packages can be fetched
# SSH, with keys, needs to be set up, so ansible can connect.
#

# Default is to check, but not make changes
check:
	ansible-playbook --check -i inventory.yml fibre01-playbook.yml
	ansible-playbook --check -i inventory.yml fibre02-playbook.yml

all: fibre01 fibre02

fibre01:
	ansible-playbook -i inventory.yml fibre01-playbook.yml

fibre02:
	ansible-playbook -i inventory.yml fibre02-playbook.yml
