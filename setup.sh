#!/bin/bash

case "$SHELL" in
    */bash | */zsh) ;;
    *)
        echo "This script is for bash or zsh, but get $SHELL instead."
        exit 1
        ;;
esac

if [[ ! -x $(command -v curl) ]]; then
    echo "curl is required to run this script!"
    echo "Exiting..."
    exit 1
fi

if [[ ! -x $(command -v fuser) ]]; then
    echo "fuser is required to run .appimage!"
    echo "Exiting..."
    exit 1
fi

BIN_DIR=$HOME/.local/bin
[[ -d "$BIN_DIR" ]] || mkdir "$BIN_DIR"

CONFIG_DIR=$HOME/.config
[[ -d "$CONFIG_DIR" ]] || mkdir "$CONFIG_DIR"

DOWNLOAD_DIR=$HOME/Downloads
[[ -d "$DOWNLOAD_DIR" ]] || mkdir "$DOWNLOAD_DIR"

THC_DIR=$HOME/THConfigs

if [[ ! -x $(command -v btop) ]]; then
    echo "Downloading btop..."
    version=1.4.6
    name=btop-x86_64-unknown-linux-musl.tbz
    url=https://github.com/aristocratos/btop/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xjf "$DOWNLOAD_DIR/$name" -C "$DOWNLOAD_DIR"
    cd "$DOWNLOAD_DIR/btop" || exit
    make install PREFIX="$HOME/.local"
fi

if [[ ! -x $(command -v csvtk) ]]; then
    echo "Downloading csvtk..."
    version=0.36.0
    name=csvtk_linux_amd64.tar.gz
    url=https://github.com/shenwei356/csvtk/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR"
fi

if [[ ! -x $(command -v duf) ]]; then
    echo "Downloading duf..."
    version=0.9.1
    name=duf_${version}_linux_x86_64.tar.gz
    url=https://github.com/muesli/duf/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" duf
fi

if [[ ! -x $(command -v dust) ]]; then
    echo "Downloading dust..."
    version=1.2.3
    name=dust-v$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/bootandy/dust/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" dust-v$version-x86_64-unknown-linux-musl/dust
fi

if [[ ! -x $(command -v eza) ]]; then
    echo "Downloading eza..."
    version=0.23.4
    name=eza_x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/eza-community/eza/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR"
fi

if [[ ! -x $(command -v fd) ]]; then
    echo "Downloading fd..."
    version=10.3.0
    name=fd-v$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/sharkdp/fd/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" fd-v$version-x86_64-unknown-linux-musl/fd
fi

if [[ ! -x $(command -v fzf) ]]; then
    echo "Downloading fzf..."
    version=0.67.0
    name=fzf-$version-linux_amd64.tar.gz
    url=https://github.com/junegunn/fzf/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" fzf
fi

if [[ ! -x $(command -v jq) ]]; then
    echo "Downloading jq..."
    version=1.8.1
    url=https://github.com/jqlang/jq/releases/download/jq-$version/jq-linux-amd64
    curl -L --progress-bar -o "$BIN_DIR/jq" "$url"
    chmod u+x "$BIN_DIR/jq"
fi

if [[ ! -x $(command -v lazygit) ]]; then
    echo "Downloading lazygit..."
    version=0.58.0
    name=lazygit_${version}_linux_x86_64.tar.gz
    url=https://github.com/jesseduffield/lazygit/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" lazygit
fi

if [[ ! -x $(command -v nvim) ]]; then
    echo "Downloading nvim..."
    version=0.11.5
    url=https://github.com/neovim/neovim/releases/download/v$version/nvim-linux-x86_64.appimage
    curl -L --progress-bar -o "$BIN_DIR/nvim" "$url"
    chmod u+x "$BIN_DIR/nvim"
fi

if [[ ! -x $(command -v rg) ]]; then
    echo "Downloading rg..."
    version=15.1.0
    name=ripgrep-$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/BurntSushi/ripgrep/releases/download/$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" ripgrep-$version-x86_64-unknown-linux-musl/rg
fi

[[ -x $(command -v starship) ]] || curl -sS https://starship.rs/install.sh | sh -s -- -b "$BIN_DIR"

if [[ ! -x $(command -v tmux) ]]; then
    echo "DOWNLOAD_DIR tmux..."
    version=3.5a
    url=https://github.com/nelsonenzo/tmux-appimage/releases/download/$version/tmux.appimage
    curl -L --progress-bar -o "$BIN_DIR/tmux" "$url"
    chmod u+x "$BIN_DIR/tmux"
fi

if [[ ! -x $(command -v uv) ]]; then
    echo "DOWNLOAD_DIR uv..."
    version=0.9.21
    name=uv-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/astral-sh/uv/releases/download/$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" uv-x86_64-unknown-linux-musl/uv uv-x86_64-unknown-linux-musl/uvx
fi

if [[ ! -x $(command -v yazi) ]]; then
    echo "DOWNLOAD_DIR yazi..."
    version=26.1.4
    name=yazi-x86_64-unknown-linux-musl.zip
    url=https://github.com/sxyazi/yazi/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    unzip -j "$DOWNLOAD_DIR/$name" "*/yazi" "*/ya" -d "$BIN_DIR"
fi

if [[ ! -x $(command -v zoxide) ]]; then
    echo "DOWNLOAD_DIR zoxide..."
    version=0.9.8
    name=zoxide-$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/ajeetdsouza/zoxide/releases/download/v$version/$name
    curl -L --progress-bar -o "$DOWNLOAD_DIR/$name" "$url"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" zoxide
fi

# link
[[ -d "$CONFIG_DIR/lazygit" ]]       || ln -s "$THC_DIR/lazygit"       "$CONFIG_DIR/lazygit"
[[ -d "$CONFIG_DIR/nvim" ]]          || ln -s "$THC_DIR/nvim"          "$CONFIG_DIR/nvim"
[[ -f "$CONFIG_DIR/starship.toml" ]] || ln -s "$THC_DIR/starship.toml" "$CONFIG_DIR"
[[ -d "$CONFIG_DIR/tmux" ]]          || ln -s "$THC_DIR/tmux"          "$CONFIG_DIR/tmux"
[[ -f "$HOME/.vimrc" ]]              || ln -s "$THC_DIR/.vimrc"        "$HOME/.vimrc"
[[ -d "$CONFIG_DIR/yazi" ]]          || ln -s "$THC_DIR/yazi"          "$CONFIG_DIR/yazi"

case "$SHELL" in
    */bash)
        RC_FILE=$HOME/.bashrc
        ;;
    */zsh)
        RC_FILE=$HOME/.zshrc
        ;;
esac
if [[ "$(rg "HOME/THConfigs/utils.sh" "$RC_FILE")" == "" ]]; then
    echo -e '\n# Automatically added by ~/THConfigs/setup.sh' >>"$RC_FILE"
    echo "source \"\$HOME/THConfigs/utils.sh\"" >>"$RC_FILE"
fi

echo "Finished, please restart the shell."
