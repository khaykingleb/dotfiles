#!/bin/bash

set -Eeuo pipefail

changes=0

plugin_installed() {
	local expected=$1
	local installed

	while IFS= read -r installed; do
		[[ "$installed" == "$expected" ]] && return 0
	done < <(kubectl krew list)

	return 1
}

command -v kubectl >/dev/null 2>&1 || {
	echo "kubectl is not available" >&2
	exit 1
}
kubectl krew version >/dev/null 2>&1 || {
	echo "Krew is not available" >&2
	exit 1
}

for plugin in images neat tree view-allocations who-can; do
	if ! plugin_installed "$plugin"; then
		echo "Installing Krew plugin: $plugin"
		kubectl krew install "$plugin"
		changes=$((changes + 1))
	fi
done

if ((changes == 0)); then
	echo "Krew is already in sync"
elif ((changes == 1)); then
	echo "Krew sync complete (1 change)"
else
	echo "Krew sync complete ($changes changes)"
fi
