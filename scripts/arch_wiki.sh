#!/usr/bin/sh

# dependacies: dmenu, arch-wiki-docs[AUR]

set -euo pipefail

BROWSER="firefox"
wikidir="/usr/share/doc/arch-wiki/html/en/"

wikidocs="$(find ${wikidir} -iname "*.html")"

main() {
	choice=$(printf '%s\n' "${wikidocs[@]}" | \
		   cut -d '/' -f8- | \
		   sed -e 's/_/ /g' -e 's/.html//g' | \
		   sort | \
		   dmenu -i -l 20 -p 'Archi Wiki Docs: ') || exit 1

	if [ "$choice" ]; then
		article=$(printf '%s\n' "${wikidir}${choice}.html" | sed 's/ /_/g')
		$BROWSER "$article"
	else
		echo "Program Terminated." && exit 0
	fi
}

main
