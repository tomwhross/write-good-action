#!/bin/sh -l

# lint markdown files and capture output
result=$(find $1 -name "*.md" | xargs npx write-good | sed -e $'s/In .\//\\\n\\\nIn .\//g' | tail -n +3)

if [ -z "$result" ]; then
	echo "No warnings from write-good"
	exit 0
fi

header=$'Here are some friendly prose warnings from [`write-good`](https://github.com/btford/write-good):\n'

result=$header$'```\n'$result$'\n```'

# add support for multiline output
result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"

echo "::set-output name=result::$result"

