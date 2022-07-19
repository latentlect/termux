#!/usr/bin/env sh

create_directory(){
    if [ ! -d "$HOME/$1" ]; then
        mkdir -p "$HOME/$1"
    fi
}

# move_files(){
#     cd "$HOME/termux/$1"
#     find -path "./*" -prune -type f | while IFS= read -r f; do
#         cp "$f" "$HOME/$2"
#     done
#     cd "$HOME/"
# }

# move_dir(){
#     cd "$HOME/termux/$1"
#     find -path "./*" -prune -type d | while IFS= read -r d; do
#         cp -r "$d" "$HOME/$2"
#     done
#     cd "$HOME/"
# }


create_directory bin
create_directory .termux
create_directory .aria2
create_directory .config
create_directory .config/bat/themes
create_directory .config/yt-dlp/

# download bat files
aria2c --dir=${HOME}/.config/bat -i "$HOME/termux/links/config"
aria2c --dir=${HOME}/.config/bat/themes -i "$HOME/termux/links/theme"

# download yt-dlp config
aria2c --dir=${HOME}/.config/yt-dlp/ -i "$HOME/termux/links/yt_dlp"

# download aria2c config
aria2c --dir=${HOME}/.aria2 -i "$HOME/termux/links/aria2c"

# download home files
aria2c --allow-overwrite=true --dir=${HOME}/ -i "$HOME/termux/links/home_files"

# download nerdfonts
aria2c --dir=${HOME}/.termux -i "$HOME/termux/links/nerdfonts"
cd "$HOME/.termux" && mv *.ttf font.ttf && cd "$HOME"

cp "$HOME/termux/others/termux-url-opener" "$HOME/bin"
cp "$HOME/termux/others/run" "$HOME/bin"
cp "$HOME/termux/others/colors.properties" "$HOME/.termux"

# sublime syntax for bat
[ -d "$HOME/.config/bat/themes" ] && bat cache --build
