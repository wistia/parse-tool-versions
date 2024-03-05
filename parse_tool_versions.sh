#!/usr/bin/env bash

while IFS= read -r line; do
  if [[ $line != \#* ]]; then
    NAME="$(echo "$line" | cut -d' ' -f1)"
    if [ -n "$PREFIX" ]; then
      NAME="$PREFIX$NAME"
    elif [ -n "$POSTFIX" ]; then
      NAME="$NAME$POSTFIX"
    fi
    if [ "$UPPERCASE" == "true" ]; then NAME="$(echo "$NAME" | tr "[:lower:]" "[:upper:]")"; fi

    VALUE=$(echo "$line" | cut -d' ' -f2-)

    echo "${NAME/-/_}=$VALUE"
  fi
done < "$FILENAME"
