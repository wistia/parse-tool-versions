#!/usr/bin/env bats

@test "Test parse_tool_versions.sh" {
  # temporary .tool-versions file with some typical values
  echo "nodejs 20.9.0" > .tool-versions
  echo "ruby 3.2.3" >> .tool-versions
  echo "gitlabci-lint 1.12.0" >> .tool-versions

  # temporary second .tool-versions file with an alternate name
  echo "python 3.12.1" >> .another-tool-versions-file

  # test default inputs (these are set in action.yml)
  run env FILENAME=.tool-versions UPPERCASE=true bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "NODEJS=20.9.0" ]]
  [[ "${lines[1]}" == "RUBY=3.2.3" ]]
  [[ "${lines[2]}" == "GITLABCI_LINT=1.12.0" ]]

  # test alternate file name
  run env FILENAME=.another-tool-versions-file UPPERCASE=true bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "PYTHON=3.12.1" ]]

  # test uppercase false
  run env FILENAME=.tool-versions UPPERCASE=false bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "nodejs=20.9.0" ]]
  [[ "${lines[1]}" == "ruby=3.2.3" ]]
  [[ "${lines[2]}" == "gitlabci_lint=1.12.0" ]]

  # test prefix
  run env FILENAME=.tool-versions UPPERCASE=true PREFIX=TOOL_VERSION_ bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "TOOL_VERSION_NODEJS=20.9.0" ]]
  [[ "${lines[1]}" == "TOOL_VERSION_RUBY=3.2.3" ]]
  [[ "${lines[2]}" == "TOOL_VERSION_GITLABCI_LINT=1.12.0" ]]

  # test postfix
  run env FILENAME=.tool-versions UPPERCASE=true POSTFIX=_TOOL_VERSION bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "NODEJS_TOOL_VERSION=20.9.0" ]]
  [[ "${lines[1]}" == "RUBY_TOOL_VERSION=3.2.3" ]]
  [[ "${lines[2]}" == "GITLABCI_LINT_TOOL_VERSION=1.12.0" ]]

  # test both prefix & postfix being set (only prefix should be used)
  run env FILENAME=.tool-versions UPPERCASE=true PREFIX=TOOL_VERSION_ POSTFIX=_TOOL_VERSION bash parse_tool_versions.sh
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" == "TOOL_VERSION_NODEJS=20.9.0" ]]
  [[ "${lines[1]}" == "TOOL_VERSION_RUBY=3.2.3" ]]
  [[ "${lines[2]}" == "TOOL_VERSION_GITLABCI_LINT=1.12.0" ]]

  # cleanup
  rm .tool-versions
  rm .another-tool-versions-file
}
