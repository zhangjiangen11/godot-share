#!/bin/bash
#
# © 2024-present https://github.com/cengiz-pz
#

PROPERTY_NAME="$1"
FILE="$2"

if [ -z "$PROPERTY_NAME" ] || [ -z "$FILE" ]; then
	echo "Usage: $0 <property_name> <path_to_config.gradle.kts>"
	exit 1
fi

if [ ! -f "$FILE" ]; then
	echo "File not found: $FILE"
	exit 1
fi

# Extract block between `extra.apply {` and the matching closing `}`
in_block=false
block=""
while IFS= read -r line; do
	if echo "$line" | grep -q 'extra[[:space:]]*\.[[:space:]]*apply[[:space:]]*{' ; then
		in_block=true
		continue
	fi
	if $in_block; then
		if echo "$line" | grep -q '^}' ; then
			break
		fi
		block="${block}"$'\n'"${line}"
	fi
done < "$FILE"

if [ -z "$block" ]; then
	echo "No extra.apply block found"
	exit 1
fi

# Parse all set("key", "...") lines, even with embedded get()
declare -A PROPS

# Capture key and raw value
while IFS= read -r line; do
	key=$(echo "$line" | sed -n 's/.*set("\([^"]*\)".*/\1/p')
	val=$(echo "$line" | sed -n 's/.*set("[^"]*",[[:space:]]*"\(.*\)").*/\1/p')
	if [ -n "$key" ] && [ -n "$val" ]; then
		PROPS["$key"]="$val"
	fi
done <<< "$block"

# Recursive resolution for ${get("...")}
resolve() {
	local value="${PROPS[$1]}"
	local loops=0
	while echo "$value" | grep -q '\${get("'; do
		value=$(echo "$value" | sed -E 's/\$\{get\("([^"]+)"\)\}/\${PROPS[\1]}/g')
		value=$(eval "echo \"$value\"")
		loops=$((loops + 1))
		[ "$loops" -gt 10 ] && break
	done
	echo "$value"
}

# Output the resolved value
if [ -n "${PROPS[$PROPERTY_NAME]}" ]; then
	resolve "$PROPERTY_NAME"
else
	echo "Property '$PROPERTY_NAME' not found or empty in $FILE"
	exit 1
fi
