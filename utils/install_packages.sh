#!/usr/bin/env sh

pkg update -y

while read package; do
    pkg install -y $package
done < "$HOME/termux/others/packages"

pkg upgrade -y
apt autoremove -y
