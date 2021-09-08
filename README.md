# parse-tool-versions
Github action that parses .tool-versions into the environment.

## Usage

```
      - name: Parse .tool-versions
        uses: wistia/parse-tool-versions@v1.0
        with:
          uppercase: 'true'
          postfix: '_tool_versions'
          filename: '.tool-versions'
```

All inputs are optional, inputs shown are defaults. by default this command appends `_tool_version` to the name of each entry in the .tool-versions file, uppercases it, and adds it to GITHUB_ENV

## Inputs

### Uppercase

set this to any string besides 'true' to use `snake_case` instead of `MACRO_CASE`

### Postfix

use to control what is appended to the tool name. `_tool_version` was chosen in the unlikely event you already have a `{tool}_VERSION` flag set; you could set `postfix` to `_version` if you wish.

### Filename

The filename read from. This can be a path
