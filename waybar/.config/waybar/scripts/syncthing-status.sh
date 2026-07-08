#!/bin/sh

case $0 in
  */*) SCRIPT_DIR=${0%/*} ;;
  *) SCRIPT_DIR=. ;;
esac
. "$SCRIPT_DIR/syncthing-common.sh"

render_unavailable() {
  printf '%s\n' "$connections_json" | jq -Rs '{
    text: " !",
    tooltip: ("Syncthing unavailable\n\n" + .),
    alt: "unavailable",
    class: "error"
  }'
}

render_status() {
  device_names_json=$(syncthing_device_names_json)

  printf '%s\n' "$connections_json" | jq -c --argjson device_names "$device_names_json" '
    def mib: (. / 1024 / 1024 | . * 100 | round / 100);
    def device_label($id):
      ($device_names[$id] // "") as $name
      | if $name == "" then $id[0:7] else $name end;
    def connection_state:
      if .connected then "connected" else "disconnected" end;
    def connection_address:
      if .address != "" then " at " + .address else "" end;
    def device_rows:
      .connections
      | to_entries
      | map("- " + device_label(.key) + " " + (.value | connection_state + connection_address))
      | if length > 0 then join("\n") else "No remote devices configured" end;

    . as $root
    | ($root.connections | length) as $total
    | ($root.connections | to_entries | map(select(.value.connected)) | length) as $connected
    | ($root.total.inBytesTotal | mib) as $in_mib
    | ($root.total.outBytesTotal | mib) as $out_mib
    | {
        text: " \($connected)/\($total)",
        tooltip: (
          "Syncthing\n"
          + "Devices: \($connected)/\($total) connected\n"
          + "In: \($in_mib) MiB  Out: \($out_mib) MiB\n\n"
          + device_rows
        ),
        alt: "\($connected) of \($total) devices connected",
        class: (
          if $total == 0 then "disconnected"
          elif $connected == $total then "connected"
          elif $connected == 0 then "disconnected"
          else "partial"
          end
        )
      }
  '
}

connections_json=$(syncthing cli show connections 2>&1)
if [ "$?" -ne 0 ]; then
  render_unavailable
else
  render_status
fi
