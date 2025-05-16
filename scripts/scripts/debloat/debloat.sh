#!/bin/bash

read -p "Have you backed up your system? (y/n): " backup_confirm
if [[ "$backup_confirm" != "y" && "$backup_confirm" != "Y" ]]; then
    echo "Please back up your system before continuing. Exiting."
    exit 1
fi

echo "Starting system cleanup and debloating..."

read -p "Do you want to uninstall unused Flatpak packages? (y/n): " flatpak_choice
if [[ "$flatpak_choice" =~ ^[Yy]$ ]]; then
    echo "Uninstalling unused Flatpak packages..."
    flatpak uninstall --unused
else
    echo "Skipping Flatpak cleanup."
fi

read -p "Do you want to clear the package cache (paru -Scc)? (y/n): " paru_choice
if [[ "$paru_choice" =~ ^[Yy]$ ]]; then
    echo "Clearing paru package cache..."
    paru -Scc
else
    echo "Skipping paru cache cleanup."
fi

read -p "Do you want to remove orphan packages? (y/n): " orphan_choice
if [[ "$orphan_choice" =~ ^[Yy]$ ]]; then
    echo "Removing orphan packages..."
    orphans=$(pacman -Qtdq)
    if [[ -z "$orphans" ]]; then
        echo "No orphan packages found."
    else
        sudo pacman -Rns $orphans
    fi
else
    echo "Skipping orphan package removal."
fi

read -p "Do you want to vacuum journal logs (keep 100MB)? (y/n): " journal_choice
if [[ "$journal_choice" =~ ^[Yy]$ ]]; then
    echo "Vacuuming journal logs..."
    sudo journalctl --vacuum-size=100M
else
    echo "Skipping journal vacuuming."
fi

echo "Cleaning systemd temporary files..."
sudo systemd-tmpfiles --clean

read -p "Do you want to analyze disk usage with ncdu (excluding /media and /run/timeshift)? (y/n): " ncdu_choice
if [[ "$ncdu_choice" =~ ^[Yy]$ ]]; then
    echo "Launching ncdu..."
    ncdu / --exclude /media --exclude /run/timeshift
else
    echo "Skipping ncdu analysis."
fi

echo "Debloat script finished."
