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

THC_DIR=$HOME/THConfigs

# starship
[[ -x $(command -v starship) ]] || curl -sS https://starship.rs/install.sh | sh -s -- -b "$BIN_DIR"

# link
[[ -d "$CONFIG_DIR/lazygit" ]]       || ln -s "$THC_DIR/lazygit"       "$CONFIG_DIR/lazygit"
[[ -d "$CONFIG_DIR/nvim" ]]          || ln -s "$THC_DIR/nvim"          "$CONFIG_DIR/nvim"
[[ -f "$CONFIG_DIR/starship.toml" ]] || ln -s "$THC_DIR/starship.toml" "$CONFIG_DIR"
[[ -d "$CONFIG_DIR/tmux" ]]          || ln -s "$THC_DIR/tmux"          "$CONFIG_DIR/tmux"
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
