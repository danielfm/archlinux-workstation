.PHONY: lint
lint:
	yamllint .
	ansible-lint .

.PHONY: run
run:
	ansible-playbook playbook.yml \
	   --vault-id archlinux-workstation@gopass-client.py \
	   --extra-vars "@vars/custom.yml"

.PHONY: vagrant
vagrant:
	vagrant halt
	vagrant up --provision

.PHONY: reboot
reboot:
	vagrant halt
	vagrant up
