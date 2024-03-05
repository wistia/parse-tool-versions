# parse-tool-versions
Github action that parses .tool-versions into the environment.

## Usage

```
  - name: Parse .tool-versions
    uses: wistia/parse-tool-versions@v2.0.0
    with:
      filename: '.tool-versions'
      uppercase: 'true'
      prefix: 'tool_version_'

  # Sometime later in the same job...
  - name: Set up Node.js environment
    uses: actions/setup-node@v3
    with:
      node-version: ${{ env.TOOL_VERSION_NODEJS }}
```

This command reads `.tool-versions` (or an alternate text file provided in `filename` input), ignores comments with leading `#` and outputs each tool name (with or without optional prefix/postfix) into `GITHUB_ENV`. All inputs are optional; by default, tool names & prefix/postfix are uppercased.

## Inputs

### Filename

The filename to read from; this can be a path

### Uppercase

Set to 'false' to use `snake_case` instead of `MACRO_CASE`

### Prefix

Use to control what is prepended to the tool name (eg. `tool_version_` w/ ruby would emit `TOOL_VERSION_RUBY`)

### Postfix

Use to control what is appended to the tool name (eg. `_tool_version` w/ ruby would emit `RUBY_TOOL_VERSION`)

## Development

### Running locally

```
env FILENAME=.tool-versions-test UPPERCASE=true PREFIX=TOOL_VERSIONS_ POSTFIX=_TOOL_VERSIONS bash parse_tool_versions.sh
```

### Tests

#### Requirements

Install [Bats-core: Bash Automated Testing System](https://bats-core.readthedocs.io/en/stable/)

```
brew install bats
```

#### Run tests

```
bats test/parse_tool_versions_test.bats
```
