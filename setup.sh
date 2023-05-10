#!/usr/bin/env bash

set -xeuo pipefail

cleanup() {
	local rv="${?}"
	if [ "${rv}" == "0" ]; then
		echo "Script has finished successfully."
	else
		echo "Script failed to complete successfully."
	fi
}

[ -z "${DEBUG+x}" ] || { echo "\"DEBUG\" environment variable is present. Enabling debugging output."; set -x; }

trap cleanup EXIT

#userdel -r ec2-user
touch /etc/skel/.hushlogin

useradd -m -U -G wheel lordvadr
mkdir ~lordvadr/.ssh
cat authorized_keys > ~lordvadr/.ssh/authorized_keys
chown -R lordvadr.lordvadr ~lordvadr
chmod 700 ~lordvadr/.ssh
chmod 600 ~lordvadr/.ssh/authorized_keys

#echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

dnf -y update

dnf -y install tmux
