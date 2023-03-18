# What is this
This repo contains both scripts & dotfiles for a GNU/Linux operating system. Currently using [Arch Linux](archlinux.org). If you use a different distro some of this repos contents may not be relevant to you.

__Note__ dotfiles are configurate files for a program/application, scripts are code that automate tasks.

## [Contents](#contents)
The docs are split into a few parts [Suckless](#suckless), [Scripts](#scripts), [Config](#config), and [Wallpaper](#wallpaper).

# Installing

Run `chmod +x install.sh` to make the install script executable then run `./install.sh` to run. 

# Contents

## Programs

The installed programs can be foun by reading the [Install file](install.sh). The script also copies wallpapers into a wallpapers directory by default (you can comment this out in the install.sh).

# Custom configs

- Fish
- Alacritty
- Xbindkeys
- Wallpapers
- Dwm

## Scripts:

### [Arch Wiki](scripts/arch_wiki.sh)

This script requires you to have <u>[dmenu](https://wiki.archlinux.org/title/Dmenu)</u> & <u>[arch-wiki-docs](https://archlinux.org/packages/community/any/arch-wiki-docs/)</u> installed. It works by creating a menu were the user enter thier search query in __dmenu__, then using the repository of arch wiki pages provided in the __arch-wiki-docs__ AUR package it displays the uses chosen wiki page in thier browser as defined in the `BROWSER` variable.