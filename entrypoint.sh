#!/bin/sh -l

# lint markdown files and capture output
result=$(find "$1" -name "*.md" -print0 | xargs -0 npx write-good | sed -e $'s/In .\//\\\n\\\nIn .\//g' | tail -n +3)

if [ -z "$result" ]; then
	echo "No warnings from write-good"
	exit 0
fi

header=$'Here are some friendly prose warnings from [`write-good`](https://github.com/btford/write-good):\n'

# prevent command execution by substituting ` for '
result=$(echo "$result" | sed "s/\`/'/g")

result=$header$'```\n'$result$'\n```'

# add support for multiline output
result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

echo "::set-output name=result::$result"

