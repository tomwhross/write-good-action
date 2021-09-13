# write-good docker action

This action lints Markdown files using [`write-good`](https://github.com/btford/write-good) and prints the output to the log.

## Inputs

### `directory`

Select a directory containing files to evaluate with `write-good`. The default is ".", the current working directory.

## Outputs

### `result`

The output from `write-good`.

## Note

Use with [`add-pr-comment`](https://github.com/marketplace/actions/add-pr-comment) to post results as comments to PR

## Example usage

```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

name: 'Trigger: Push action'
jobs:
  write_good_job:
    runs-on: ubuntu-latest
    name: A job to lint Markdown files
    steps:
    - uses: actions/checkout@v2
    - name: write-good action step
      id: write-good
      uses: tomwhross/write-good-action@v1.2
    # Use the output from the `write-good` step
    - name: Get the write-good output
      run: echo "${{ steps.write-good.outputs.result }}"
    - name: Post comment
      uses: mshick/add-pr-comment@v1
      if: ${{ steps.write-good.outputs.result }}
      with:
        message: |
          ${{ steps.write-good.outputs.result }}
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        repo-token-user-login: 'github-actions[bot]' # The user.login for temporary GitHub tokens
        allow-repeats: false # This is the default
```
