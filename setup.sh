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

for f in setup.d/*.sh; do
	echo "========== examining ${f} =========="
	bash -n "${f}" || { echo "${f} fails linting, skipping."; continue; }
  ret=0
  "${f}" || ret="${?}"
	echo "=============== ${f} Exited with return code ${ret} ======="
done
