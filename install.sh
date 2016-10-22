#!/bin/bash

PLAYBOOKS="mysql-install.yml"

ansible-galaxy install -r ansible/requirements.yml

for f in $PLAYBOOKS; do
	ansible-playbook ansible/playbooks/${f} -e @ansible/vars/global.yml
done

