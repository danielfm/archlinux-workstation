.PHONY: lint
lint:
	yamllint .
	ansible-playbook main.yml --syntax-check
	ansible-lint main.yml
