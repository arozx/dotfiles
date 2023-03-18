#!/bin/usr/sh

cd /home/user/

# Update pacman
echo "Updating pacman, will probably take some time"
sudo pacman --noconfirm --needed -Syu

# Install dependecies
echo "Installing a bunch of stuff"
sudo pacman -S --noconfirm --needed xorg xorg-xinit\
    git \
    gcc \
    python3 gcc base-devel      \
    ttf-ubuntu-font-family          \
    rofi                            \
    papirus-icon-theme              \
    nodejs                          \
    npm                             \
    cmake                           \
    ttf-nerd-fonts-symbols          \
    yay				    \
    neofetch			    \
    fish			    \
    firefox			    \
    lf				    \
    gotop			    \
    arch-wiki-docs  \
    xbindkeys   \
    xbindkeys_config \
    tcc \
    dmenu \
    rofi \
    dmenu-rofi \
    neovim \
    flatpak \
    flameshot \
    pamixer \
    opendoas

# Install rust & alacritty
echo "##############################"
echo "installing Rust and alacritty"
echo "##############################"
sudo pacman -S --noconfirm --needed rustup cargo

rustup default stable

sudo pacman -S --noconfirm --needed alacritty
yay -S --noconfirm --needed archlinux-tweak-tool-git
yay -S --noconfirm --needed brave-bin
yay -S --noconfirm --needed vscodium-bin 

mkdir .config
mkdir scripts
mkdir suckless

cd .config
mkdir alacritty
mkdir rofi
mkdir fish
mkdir wallpaper

cd ..
cp dotfiles/config/rofi/config.rasi .config/rofi/
cp dotfiles/config/rofi/launcher.rasi .config/rofi/
cp dotfiles/config/.xbindkeysrc .xbindkeysrc
cp dotfiles/config/fish .config/fish

# scripts
cp -r dotfiles/scripts scripts
chmod +x scripts/arch_wiki.sh/
chmod +x scripts/bookmarks.sh/
chmod +x scripts/todo.sh/
chmod +x scripts/dwm_bar.sh/


cp -r dotfiles/wallpapers/ .config/wallpaper/

# suckless
cp -r dotfiles/suckless/ .
cd suckless
sudo make & sudo make install

# Interactive
# Neovim install & config
echo "###########################"
echo "installing astro vim config"
echo "###########################"

# Nerdfonts
yay -S --noconfirm --needed nerd-fonts-git

# Neovim
yay -S --noconfirm --needed neovim

# Tree sitter
cargo install tree-sitter-cli

# Clone astrovim repo
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim

echo "##################################"
echo "navigate to https://astronvim.com/"
echo "##################################"
