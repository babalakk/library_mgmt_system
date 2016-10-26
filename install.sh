#!/bin/bash

set -x -e

PLAYBOOKS="\
essential-install.yml
mysql-install.yml
nginx-install.yml
"

ANSIBLE_REPO="git://github.com/ansible/ansible.git"
ANSIBLE_WORKING_DIR="/opt/ansible"

install_ansible() {
	git clone $ANSIBLE_REPO $ANSIBLE_WORKING_DIR --recursive
	cd $ANSIBLE_WORKING_DIR
	source ./hacking/env-setup
	easy_install pip
	pip install paramiko PyYAML Jinja2 httplib2 six
	cd -
}

prepare_playbook() {
    cat > playbook.sh << 'EOF'
#!/bin/bash

source /opt/ansible/hacking/env-setup
ANSIBLE_VARS=`ls ansible/vars`
process_vars() {
	local vars=""
	local buf=""
	for v in $ANSIBLE_VARS; do
		buf=`echo $v | sed 's/ //g'`
		vars="$vars -e @ansible/vars/$buf"
	done
	echo "$vars"
}

ansible_vars="`process_vars`"
ansible-playbook $ansible_vars $@
    
EOF
    chmod 755 playbook.sh
}

main() {
	apt update && apt install gcc python-dev python-setuptools libssl-dev -y
	[ ! -d $ANSIBLE_WORKING_DIR ] && install_ansible

	#ansible-galaxy install -r ansible/requirements.yml
    prepare_playbook
	for f in $PLAYBOOKS; do
		./playbook.sh ansible/playbooks/${f}
	done
}

main
