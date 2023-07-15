#!/usr/bin/sh

# BROWSER="$BROWSER"

BROWSER="firefox"

declare -a options=(

"dwm - https://gist.github.com/erlendaakre/12eb90eef84a3ab81f7b531e516c9594"
"1 - https://classroom.google.com"
"2 - https://mokeytype.com"
"3 - https://mail.google.com"
"4 - https://github.com"
"5 - https://192.168.50.1:8443"
"6 - https://192.168.50.29"
"7 - https://10.232.1.64:8006"
"8 - https://gtfobins.github.io"
"9 - https://www.reddit.com/r/selfhosted/comments/105k3jm/how_are_you_archiving_websites_you_visit"
"10 - https://reddit.com"
"11 - https://bbernhard.github.io/signal-cli-rest-api/#/"
"12 - https://github.com/sshuttle/sshuttle"
"13 - https://github.com/inbucket/inbucket"
"14 - https://js.wiki"
"15 - https://about.gitlab.com"
"16 - https://prometheus.io/docs/introduction/overview"
"17 - https://grafana.com/oss/loki"
"18 - https://grafana.com"
"19 - https://doc.traefik.io/traefik"
"20 - https://www.redhat.com/en/blog/argocd-and-gitops-whats-next"
"21 - https://fluxcd.io"
"22 - https://fluxcd.io"
"23 - https://longhorn.io"
"34 - https://www.rancher.com"
"35 - https://github.com/vmstan/gravity-sync"
"36 - https://github.com/linuxserver/Heimdall"
"37 - https://geti2p.net/en/download"
"37 - https://beta.openai.com/docs/introduction"
"39 - https://chat.openai.com"
"40 - https://creality3d.shop/collections/freeshipping-3dprinters/products/creality3d-ld-001-dlp-light-curing-3d-printer-silver-eu-plug-2"
"41 - https://learn.onshape.com/learn/course/fundamentals-part-design-using-part-studios/creating-patterns-and-mirrors-in-a-part-studio/circular-pattern?page=1"
"41 - https://displate.com/displate/5406128"
"42 - https://openrocket.info"
"43 - https://doc.rust-lang.org/cargo/getting-started/first-steps.html"
"44 - https://gridfinity.xyz/specification"
"45 - https://pine64.com/product-category/single-board-computers"
"46 - https://github.com/Sweets/tiramisu"
"47 - https://github.com/dudik/herbe"
"48 - https://nitter.net/Twitter"
"49 - https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html"
"50 - https://www.nerdfonts.com/cheat-sheet"
"51 - https://doc.cat-v.org/bell_labs"
"52 - https://www.gutenberg.org"
"53 - https://about.jstor.org"
"54 - https://sites.google.com/felsted.org/researchresources/home"
"55 - https://www.nature.com/articles/s41562-021-01197-3"
"56 - https://improbable.com/ig"
"57 - https://www.measurementlab.net"
"58 - https://i2pd.website"
"59 - https://github.com/mig-hub/yabi"
"60 - https://leetcode.com/accounts/signup"
"61 - https://use04.thegood.cloud/login?redirect_url=/apps/calendar/dayGridMonth/now"
"62 - https://pypi.org/project/mal-api"
"quit"
)


choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 20 -p "Bookmarks ")

if [[ "$choice" == quit ]]; then
	echo "Program Terminated." && exit 1
elif [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$BROWSER "$cfg"
else
	echo "Program Terminated." && exit 1
fi

