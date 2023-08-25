#!/bin/usr/sh

# Change this to your username
username="user";

# Change to home directory
cd /home/$username;

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
    tcc \
    dmenu \
    neovim \
    flatpak \
    flameshot \
    pamixer \
    opendoas \
    feh


# Install rust & alacritty
echo "##############################"
echo "installing Rust and alacritty"
echo "##############################"
sudo pacman -S --noconfirm --needed rustup cargo

rustup default stable

sudo pacman -S --noconfirm --needed alacritty
yay -S --noconfirm --needed brave-bin

mkdir .config
mkdir scripts
mkdir suckless

cd .config
mkdir alacritty
mkdir rofi
mkdir fish
mkdir wallpaper
cd ..

# Copy autostart to users home directory
cp dotfiles/config/.xprofile .

# set wallpaper
feh --bg-scale .config/wallpaper/nature-39-1920x1080.jpg


cp dotfiles/config/rofi/config.rasi .config/rofi/
cp dotfiles/config/rofi/launcher.rasi .config/rofi/
cp dotfiles/config/fish .config/fish

# scripts
cp -r dotfiles/scripts scripts
chmod +x scripts/*


cp -r dotfiles/wallpapers/ .config/wallpaper/

# dwm
cp -r dotfiles/suckless/ .
cd suckless/dwm
sudo make & sudo make install
cd ..
cd ..

# herbe
git clone https://github.com/dudik/herbe
cd herbe
sudo make install
cd ..

# Interactive
# Neovim install & config
echo "########################"
echo "Installing neovim config"
echo "########################"

# Nerdfonts
yay -S --noconfirm --needed nerd-fonts-git

# Neovim
yay -S --noconfirm --needed neovim

# Tree sitter
cargo install tree-sitter-cli
