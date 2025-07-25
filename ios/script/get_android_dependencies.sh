#!/bin/bash
#
# © 2024-present https://github.com/cengiz-pz
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANDROID_DIR=$(realpath $SCRIPT_DIR/../../android)
TOML_FILE="$ANDROID_DIR/gradle/libs.versions.toml"
declare -A versions_map
declare -a library_versions

# Extract [versions]
in_versions=false
while IFS= read -r line; do
	if [[ $line =~ ^\[versions\] ]]; then
		in_versions=true
		continue
	elif [[ $line =~ ^\[.*\] ]]; then
		in_versions=false
	fi

	if $in_versions && [[ $line =~ ^([a-zA-Z0-9_-]+)\ *=\ *\"([^\"]+)\" ]]; then
		key="${BASH_REMATCH[1]}"
		value="${BASH_REMATCH[2]}"
		versions_map["$key"]="$value"
	fi
done < "$TOML_FILE"

# Extract [libraries] and resolve version.ref
in_libraries=false
while IFS= read -r line; do
	if [[ $line =~ ^\[libraries\] ]]; then
		in_libraries=true
		continue
	elif [[ $line =~ ^\[.*\] ]]; then
		in_libraries=false
	fi

	if $in_libraries && [[ $line =~ ^([a-zA-Z0-9_-]+)\ *=.*version\.ref\ *=\ *\"([^\"]+)\" ]]; then
		lib="${BASH_REMATCH[1]}"
		version_key="${BASH_REMATCH[2]}"
		resolved_version="${versions_map[$version_key]}"
		if [[ -n $resolved_version ]]; then
			library_versions+=("$lib:$resolved_version")
		fi
	fi
done < "$TOML_FILE"

quoted_entries=()
for entry in "${library_versions[@]}"; do
	quoted_entries+=("\"$entry\"")
done

IFS=','; echo "${quoted_entries[*]}"
