# ansible-arch-boostrap
# (c) 2015 James Barwell, http://jamesbarwell.co.uk
# https://github.com/JamesBarwell/ansible-arch-bootstrap
# license MIT


# Defaults

limit = all
pub-key-path = ./key/host.pub
priv-key-path = ./key/host


#  Utilities

ssh:
	ssh root@$(shell ansible $(limit) -i hosts --list-hosts | head -n1 | tr -d ' ') -i $(priv-key-path) $(params)

ping:
	ansible $(limit) -i hosts -u root --private-key $(priv-key-path) -m ping $(params)

command:
ifndef command
	$(error command parameter is not set)
endif
	ansible $(limit) -i hosts -u root --private-key $(priv-key-path) -m shell -a "$(command)" $(params)


# Build

bootstrap: create-key upload-key install-python build

create-key:
	if [ ! -f $(priv-key-path) ] ; then \
	mkdir -p key; \
	ssh-keygen -C "root@host" -f $(priv-key-path) -N ""; \
	fi
	chmod --changes 0600 $(priv-key-path)

upload-key:
	$(eval key-contents:= $(shell cat $(pub-key-path)))
	ansible $(limit) -i hosts -u root --ask-pass -m authorized_key -a "user=root key='$(key-contents)'" $(params)

remove-key:
	$(eval key-contents:= $(shell cat $(pub-key-path)))
	ansible $(limit) -i hosts -u root --private-key $(priv-key-path) -m authorized_key -a "user=root key='$(key-contents)' state=absent" $(params)

install-python:
	ansible $(limit) -i hosts -u root --private-key $(priv-key-path) -m raw -a '/usr/bin/pacman -Sy --noconfirm python2' $(params)

build:
	ansible-playbook build.yml -i hosts -u root --private-key $(priv-key-path) --limit=$(limit) $(params)

check:
	ansible-playbook build.yml -i hosts -u root --private-key $(priv-key-path) --limit=$(limit) --check --diff $(params)
