#!/usr/bin/env sh

# pipenv, yt-dlp
python3 -m pip install --upgrade pip
python3 -m pip install -U pipenv yt-dlp


append_line(){
    LINE="$1"
    FILE="$2"
    `grep -qxF -- "$LINE" "$FILE" || echo -en "$LINE" >> "$FILE"`
}


install_lvim(){
    if command -v nvim > /dev/null; then
        #  Pre-requisites
        pkg install -y ripgrep rust
        npm install -g prettier
        python3 -m pip install -U pynvim autopep8 flake8
        cargo install stylua

        bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies

		if command -v lvim > /dev/null; then
			append_line '\nalias nvim="lvim"\n' "$HOME/.aliases"
            lvim
		fi

        # uninstall lvim
        # bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
    fi

}


install_fzf(){
    if ! command -v fzf > /dev/null; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
}


install_fzf
install_lvim
