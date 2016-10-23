#!/bin/bash

set -x -e

PLAYBOOKS="\
mysql-install.yml
"

ANSIBLE_REPO="git://github.com/ansible/ansible.git"
ANSIBLE_WORKING_DIR="/opt/ansible"
ANSIBLE_VARS=`ls ansible/vars`

install_ansible() {
	git clone $ANSIBLE_REPO $ANSIBLE_WORKING_DIR --recursive
	cd $ANSIBLE_WORKING_DIR
	source ./hacking/env-setup
	easy_install pip
	pip install paramiko PyYAML Jinja2 httplib2 six
	cd -
}

setup_ansible() {
	cd $ANSIBLE_WORKING_DIR
	source ./hacking/env-setup
	cd -
}

main() {

	apt update && apt install gcc python-dev python-setuptools libssl-dev -y
	[ -d $ANSIBLE_WORKING_DIR ] && setup_ansible || install_ansible

	ansible-galaxy install -r ansible/requirements.yml

	for f in $PLAYBOOKS; do
		ansible-playbook ansible/playbooks/${f} -e @${ANSIBLE_VARS}
	done
}

main
