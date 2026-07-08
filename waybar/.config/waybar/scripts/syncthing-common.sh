#!/bin/sh

syncthing_config_path() {
  printf '%s/config.xml\n' "${STCONFDIR:-${STHOMEDIR:-$HOME/.local/state/syncthing}}"
}

syncthing_device_names_json() {
  config_path=$(syncthing_config_path)

  if ! command -v xmlstarlet >/dev/null 2>&1 || [ ! -r "$config_path" ]; then
    printf '{}\n'
    return
  fi

  xmlstarlet sel \
    -t \
    -m '/configuration/device' \
    -v '@id' \
    -o "$(printf '\t')" \
    -v '@name' \
    -n \
    "$config_path" 2>/dev/null \
    | jq -Rn '
        reduce inputs as $line ({};
          ($line | split("\t")) as $parts
          | if ($parts | length) >= 2 and $parts[0] != "" then
              . + {($parts[0]): $parts[1]}
            else
              .
            end
        )
      '
}
