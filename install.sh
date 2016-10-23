#!/bin/bash

set -x -e

PLAYBOOKS="\
phpmyadmin-install.yml
mysql-install.yml
"

ANSIBLE_REPO="git://github.com/ansible/ansible.git"
ANSIBLE_WORKING_DIR="/opt/ansible"

install_ansible() {
	git clone $ANSIBLE_REPO $ANSIBLE_WORKING_DIR --recursive
	cd $ANSIBLE_WORKING_DIR
	source ./hacking/env-setup
	cd -
}

main() {
	[ ! -d $ANSIBLE_WORKING_DIR ] &&
		install_ansible

	ansible-galaxy install -r ansible/requirements.yml

	for f in $PLAYBOOKS; do
		ansible-playbook ansible/playbooks/${f} -e @ansible/vars/global.yml
	done
}

main
