#!/usr/bin/env bash
set -u

case ${BASH_SOURCE[0]} in
  */*) SCRIPT_DIR=${BASH_SOURCE[0]%/*} ;;
  *) SCRIPT_DIR=. ;;
esac
# shellcheck source=scripts/syncthing-common.sh
. "$SCRIPT_DIR/syncthing-common.sh"

require_gum() {
  command -v gum >/dev/null 2>&1 && return

  printf 'Syncthing dashboard requires gum.\n\nInstall gum to use this dashboard, then reopen it.\n'
  if [ -t 0 ]; then
    printf '\nPress any key to close...'
    read -r -n 1 _
    printf '\n'
  fi
  exit 130
}

render_unavailable() {
  gum style --border rounded --padding "1 2" --border-foreground 1 --foreground 1 "Syncthing unavailable"
  gum format --type code -- "$connections_json"
}

build_summary() {
  jq -rn \
    --argjson connections "$connections_json" \
    --argjson system "$system_json" \
    --argjson config "$config_json" '
      def mib: (. / 1024 / 1024 | . * 100 | round / 100);
      ($connections.connections | length) as $total
      | ($connections.connections | to_entries | map(select(.value.connected)) | length) as $connected
      | [
          "Devices: \($connected)/\($total) connected",
          "Transfer: \($connections.total.inBytesTotal | mib) MiB in / \($connections.total.outBytesTotal | mib) MiB out",
          "GUI: \($system.guiAddressUsed // "unknown")",
          "Uptime: \((($system.uptime // 0) / 3600) | floor)h \(((($system.uptime // 0) % 3600) / 60 | floor))m",
          "Discovery: \(if ($system.discoveryEnabled // false) then "enabled" else "disabled" end)",
          "Restart required: \(if ($config.requiresRestart // false) then "yes" else "no" end)"
        ]
      | join("\n")
    '
}

build_device_rows() {
  device_names_json=$(syncthing_device_names_json)

  jq -r --argjson device_names "$device_names_json" '
    def device_label($id):
      ($device_names[$id] // "") as $name
      | if $name == "" then $id[0:7] else $name end;

    .connections
    | to_entries
    | if length == 0 then
        "-,none,-,0 MiB,0 MiB"
      else
        (.[] | [
          device_label(.key),
          (if .value.connected then "connected" else "offline" end),
          (if .value.address == "" then "-" else .value.address end),
          (((.value.inBytesTotal / 1024 / 1024) * 100 | round / 100 | tostring) + " MiB"),
          (((.value.outBytesTotal / 1024 / 1024) * 100 | round / 100 | tostring) + " MiB")
        ])
        | @csv
      end
  ' <<<"$connections_json"
}

render_dashboard() {
  summary=$(build_summary)
  devices=$(build_device_rows)

  gum style --foreground 15 --bold "Syncthing"
  gum style --foreground 8 "$summary"
  printf '\n'
  printf '%s\n' "$devices" | gum table --print --separator "," --border rounded --columns Device,State,Address,In,Out
}

require_gum

connections_json=$(syncthing cli show connections 2>&1)
if (( $? != 0 )); then
  render_unavailable
  exit 0
fi

system_json=$(syncthing cli show system 2>/dev/null || printf '{}')
config_json=$(syncthing cli show config-status 2>/dev/null || printf '{}')

render_dashboard
