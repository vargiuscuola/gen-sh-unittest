# gen-sh-unittest

GitHub Action to automatically unit test shell scripts on every git push using [shunit2](https://github.com/kward/shunit2) and [bash-spec-2](https://github.com/holmesjr/bash-spec-2) unit test frameworks.

## Usage

Create unit test cases with the syntax of [shunit2](https://github.com/kward/shunit2) and [bash-spec-2](https://github.com/holmesjr/bash-spec-2) unit test frameworks. Store them in one or more script files named `<filename>.shunit2` or `<filename>.bashspec2`, accordingly to the framework used, and residing in the root of the repository.
You **do not need** to source the `shunit2` and `bash-spec-2` scripts inside your unit testing files: it will be done for you by this GitHub Action.

Then create a GitHub workflow referencing `vargiuscuola/gen-sh-unittest`.
For example, put in a workflow with path `.github/workflows/sh-unittest.yml` the following content:
```yaml
name: Shell Scripts Unit Testing

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Github Action gen-sh-unittest
      id: action-gen-sh-unittest
      uses: vargiuscuola/gen-sh-unittest@master
    - name: gensh-unittest result
      run: echo "The result of gensh-unittest Action was ${{ steps.action-gen-sh-unittest.outputs.result }}"
    - name: Commit files
      run: |
        echo ${{ github.ref }}
        git add .
        git config --local user.email "action@github.com"
        git config --local user.name "GitHub Action"
        git commit -m "CI: Automated build push" -a | exit 0
    - name: Push changes
      if: github.ref == 'refs/heads/master'
      uses: ad-m/github-push-action@master
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
```

This will run all unit testing files found in the directory `test` in the root of the repository.
The fail of any of the unit testing script will cause the failing of this GitHub Action, and consequently of all the workflows referencing it.
