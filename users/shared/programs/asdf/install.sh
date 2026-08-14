#!/bin/bash

set -Eeuo pipefail

tool_versions_file="$HOME/.tool-versions"
changes=0

announce() {
	if ((changes > 0)); then
		echo
	fi
	echo "$1"
}

plugin_installed() {
	local expected=$1
	local installed

	while IFS= read -r installed; do
		[[ "$installed" == "$expected" ]] && return 0
	done < <(asdf plugin list)

	return 1
}

krew_plugin_installed() {
	local expected=$1
	local installed

	while IFS= read -r installed; do
		[[ "$installed" == "$expected" ]] && return 0
	done < <(kubectl krew list)

	return 1
}

command -v asdf >/dev/null 2>&1 || {
	echo "asdf is not available" >&2
	exit 1
}
[[ -r "$tool_versions_file" ]] || {
	echo "$tool_versions_file is not readable; apply the Home Manager configuration first" >&2
	exit 1
}

while IFS= read -r line || [[ -n "$line" ]]; do
	line=${line%%#*}
	read -r -a fields <<<"$line"
	((${#fields[@]} > 1)) || continue

	plugin=${fields[0]}
	if ! plugin_installed "$plugin"; then
		announce "Adding asdf plugin: $plugin"
		if [[ "$plugin" == "supabase-cli" ]]; then
			asdf plugin add "$plugin" https://github.com/gavinying/asdf-supabase-cli.git
		else
			asdf plugin add "$plugin"
		fi
		changes=$((changes + 1))
	fi

	for version in "${fields[@]:1}"; do
		[[ "$version" == "system" || "$version" == path:* ]] && continue
		asdf where "$plugin" "$version" >/dev/null 2>&1 && continue

		announce "Installing $plugin $version"
		asdf install "$plugin" "$version"
		changes=$((changes + 1))
	done
done <"$tool_versions_file"

asdf reshim

if ! krew_plugin_installed neat; then
	announce "Installing Krew plugin: neat"
	kubectl krew install neat
	changes=$((changes + 1))
fi

if ! krew_plugin_installed view-allocations; then
	announce "Installing Krew plugin: view-allocations"
	kubectl krew install view-allocations
	changes=$((changes + 1))
fi

if ((changes == 0)); then
	echo "asdf is already in sync"
elif ((changes == 1)); then
	echo
	echo "asdf sync complete (1 change)"
else
	echo
	echo "asdf sync complete ($changes changes)"
fi
