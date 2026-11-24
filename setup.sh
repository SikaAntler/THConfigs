#!/bin/bash

set -e -o pipefail

case "$SHELL" in
    */bash | */zsh) ;;
    *)
        echo "This script is for bash or zsh, but get $SHELL instead."
        exit 1
        ;;
esac

BIN_DIR=$HOME/.local/bin
export PATH="$BIN_DIR:$PATH"

if [[ ! -x $(command -v curl) ]]; then
    echo "curl is required to run this script!"
    echo "Exiting..."
    exit 1
fi

CONFIG_DIR=$HOME/.config
DOWNLOAD_DIR=$HOME/Downloads
THC_DIR=$HOME/THConfigs
mkdir -p "$BIN_DIR" "$CONFIG_DIR" "$DOWNLOAD_DIR"

download() {
    curl -fL --retry 3 --progress-bar -o "$2.part" "$1" && mv -f -- "$2.part" "$2"
}

if [[ ! -x $(command -v bat) ]]; then
    echo "Downloading bat..."
    version=0.26.1
    name=bat-v$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/sharkdp/bat/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" bat-v$version-x86_64-unknown-linux-musl/bat
fi

if [[ ! -x $(command -v btop) ]]; then
    echo "Downloading btop..."
    version=1.4.7
    name=btop-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/aristocratos/btop/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$DOWNLOAD_DIR"
    cd "$DOWNLOAD_DIR/btop" || exit
    make install PREFIX="$HOME/.local"
fi

if [[ ! -x $(command -v duf) ]]; then
    echo "Downloading duf..."
    version=0.9.1
    name=duf_${version}_linux_x86_64.tar.gz
    url=https://github.com/muesli/duf/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" duf
fi

if [[ ! -x $(command -v dust) ]]; then
    echo "Downloading dust..."
    version=1.2.6
    name=dust-v$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/bootandy/dust/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" dust-v$version-x86_64-unknown-linux-musl/dust
fi

if [[ ! -x $(command -v eza) ]]; then
    echo "Downloading eza..."
    version=0.23.5
    name=eza_x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/eza-community/eza/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR"
fi

if [[ ! -x $(command -v fd) ]]; then
    echo "Downloading fd..."
    version=10.5.0
    name=fd-v$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/sharkdp/fd/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" fd-v$version-x86_64-unknown-linux-musl/fd
fi

if [[ ! -x $(command -v fzf) ]]; then
    echo "Downloading fzf..."
    version=0.74.5
    name=fzf-$version-linux_amd64.tar.gz
    url=https://github.com/junegunn/fzf/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" fzf
fi

if [[ ! -x $(command -v jq) ]]; then
    echo "Downloading jq..."
    version=1.8.2
    url=https://github.com/jqlang/jq/releases/download/jq-$version/jq-linux-amd64
    download "$url" "$BIN_DIR/jq"
    chmod u+x "$BIN_DIR/jq"
fi

if [[ ! -x $(command -v lazygit) ]]; then
    echo "Downloading lazygit..."
    version=0.66.2
    name=lazygit_${version}_linux_x86_64.tar.gz
    url=https://github.com/jesseduffield/lazygit/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" lazygit
fi

if ! nvim --version >/dev/null 2>&1; then
    version=0.12.6
    stem=nvim-linux-x86_64
    url=https://github.com/neovim/neovim/releases/download/v$version
    candidate=$(mktemp -d "$BIN_DIR/.nvim.XXXXXXXX")
    trap 'rm -rf -- "$candidate"' EXIT
    if download "$url/$stem.appimage" "$candidate/nvim" && chmod u+x "$candidate/nvim" && "$candidate/nvim" --version >/dev/null 2>&1; then
        mv -Tf "$candidate/nvim" "$BIN_DIR/nvim"
    else
        echo "Could not run the Neovim AppImage. Installing the tar.gz distribution..."
        download "$url/$stem.tar.gz" "$DOWNLOAD_DIR/$stem.tar.gz"
        opt_dir=$HOME/.local/opt
        mkdir -p "$opt_dir"
        install_dir=$(mktemp -d "$opt_dir/nvim-$version.XXXXXXXX")
        trap 'rm -rf -- "$candidate" "$install_dir"' EXIT
        tar -xzf "$DOWNLOAD_DIR/$stem.tar.gz" --strip-components=1 -C "$install_dir"
        "$install_dir/bin/nvim" --version >/dev/null
        ln -s "$install_dir/bin/nvim" "$candidate/link"
        mv -Tf "$candidate/link" "$BIN_DIR/nvim"
    fi
    trap - EXIT
    rm -rf -- "$candidate"
fi

if [[ ! -x $(command -v resvg) ]]; then
    echo "Downloading resvg..."
    version=0.48.1
    name=resvg-linux-x86_64.tar.gz
    url=https://github.com/linebender/resvg/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR"
fi

if [[ ! -x $(command -v rg) ]]; then
    echo "Downloading rg..."
    version=15.2.0
    name=ripgrep-$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/BurntSushi/ripgrep/releases/download/$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" ripgrep-$version-x86_64-unknown-linux-musl/rg
fi

[[ -x $(command -v starship) ]] || curl -fsSL --retry 3 https://starship.rs/install.sh | sh -s -- -b "$BIN_DIR"

if [[ ! -x $(command -v tmux) ]]; then
    version=3.8
    name=tmux-$version.tar.gz
    if command -v apt-get >/dev/null; then
        missing=()
        for package in build-essential pkg-config libevent-dev libncurses-dev bison; do
            if [[ $(dpkg-query -W -f='${db:Status-Status}' "$package" 2>/dev/null) != installed ]]; then
                missing+=("$package")
            fi
        done
        if ((${#missing[@]})); then
            sudo_cmd=()
            if ((EUID != 0)); then
                sudo_cmd=(sudo)
            fi
            "${sudo_cmd[@]}" apt-get update
            "${sudo_cmd[@]}" apt-get install -y "${missing[@]}"
        fi
    fi
    if ! tar -tzf "$DOWNLOAD_DIR/$name" "tmux-$version/configure" >/dev/null 2>&1; then
        download "https://github.com/tmux/tmux/releases/download/$version/$name" "$DOWNLOAD_DIR/$name"
    fi
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$DOWNLOAD_DIR"
    (   
        cd "$DOWNLOAD_DIR/tmux-$version"
        ./configure --prefix="$HOME/.local"
        make -j"$(nproc)"
        make install
    )
fi

if [[ ! -x $(command -v uv) || ! -x $(command -v uvx) ]]; then
    echo "Downloading uv..."
    version=0.13.5
    stem=uv-x86_64-unknown-linux-musl
    name=$stem.tar.gz
    url=https://github.com/astral-sh/uv/releases/download/$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" "$stem/uv" "$stem/uvx"
fi

if [[ ! -x $(command -v yazi) || ! -x $(command -v ya) ]]; then
    echo "Downloading yazi..."
    version=26.9.1
    name=yazi-x86_64-unknown-linux-musl.zip
    url=https://github.com/sxyazi/yazi/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    unzip -oj "$DOWNLOAD_DIR/$name" "*/yazi" "*/ya" -d "$BIN_DIR"
fi

if [[ ! -x $(command -v yq) ]]; then
    echo "Downloading yq..."
    version=4.54.1
    name=yq_linux_amd64.tar.gz
    url=https://github.com/mikefarah/yq/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" --strip-components=1 -C "$BIN_DIR" ./yq_linux_amd64
    mv "$BIN_DIR/yq_linux_amd64" "$BIN_DIR/yq"
fi

if [[ ! -x $(command -v zoxide) ]]; then
    echo "Downloading zoxide..."
    version=0.10.0
    name=zoxide-$version-x86_64-unknown-linux-musl.tar.gz
    url=https://github.com/ajeetdsouza/zoxide/releases/download/v$version/$name
    download "$url" "$DOWNLOAD_DIR/$name"
    tar -xzf "$DOWNLOAD_DIR/$name" -C "$BIN_DIR" zoxide
fi

# link
[[ -d "$CONFIG_DIR/lazygit" ]]       || ln -s "$THC_DIR/lazygit"       "$CONFIG_DIR/lazygit"
[[ -d "$CONFIG_DIR/nvim" ]]          || ln -s "$THC_DIR/nvim"          "$CONFIG_DIR/nvim"
[[ -f "$CONFIG_DIR/starship.toml" ]] || ln -s "$THC_DIR/starship.toml" "$CONFIG_DIR"
[[ -d "$CONFIG_DIR/tmux" ]]          || ln -s "$THC_DIR/tmux"          "$CONFIG_DIR/tmux"
[[ -f "$HOME/.inputrc" ]]            || ln -s "$THC_DIR/.inputrc"      "$HOME/.inputrc"
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
if [[ ! -f "$RC_FILE" ]] || ! grep -Eq '^[[:space:]]*(source|\.)[[:space:]]+("([$](HOME|\{HOME\}))/THConfigs/utils\.sh"|([$](HOME|\{HOME\})|~)/THConfigs/utils\.sh)[[:space:]]*(#.*)?$' "$RC_FILE"; then
    echo -e '\n# Automatically added by ~/THConfigs/setup.sh' >>"$RC_FILE"
    echo "source \"\$HOME/THConfigs/utils.sh\"" >>"$RC_FILE"
fi

echo "Finished, please restart the shell."
