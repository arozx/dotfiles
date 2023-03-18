# What is this
This repo contains both scripts & dotfile for GNU/Linux. Currently using a <u>[Arch Linux](archlinux.org)</u> system. If you use a different distrobution some of this repos contents may not be relevant to you.

__Note__ dotfiles are configurate files for a program/application, scripts are peices of code that automate tasks.

## [Contents](#contents)
The docs are split into two main parts, [dotfiles](#dotfiles) and [scripts](#scripts).  

## Dotfiles:

### [Fish](https://fishshell.com/)

[This](~/dotfiles/config/fish) is my full configuration for Fish. To use my configuration for Fish you need to have <u>[ohmy-fish](https://github.com/oh-my-fish/oh-my-fish)</u> installed due to the theming I use and other features the framework provides. The config files can be found [here](~/dotfiles/config/fish).

### [Alacritty](alacritty.org)

[Alacritty](alacritty) is a terminal emulator with extensive customisation. This dotfile requires Alacritty to be installed. To install this config simpily move the [alacritty.yml](dotfiles/alacritty.yml) to __~/.config/alacritty/alacritty.yml__ using the `mv` command or alternately copy it using the `cp` command the the above mentioned path.

## Scripts:

### [Arch Wiki](scripts/arch_wiki.sh)

This script requires you to have <u>[dmenu](https://wiki.archlinux.org/title/Dmenu)</u> & <u>[arch-wiki-docs](https://archlinux.org/packages/community/any/arch-wiki-docs/)</u> installed. It works by creating a menu were the user enter thier search query in __dmenu__, then using the repository of arch wiki pages provided in the __arch-wiki-docs__ AUR package it displays the uses chosen wiki page in thier browser as defined in the `BROWSER` variable.