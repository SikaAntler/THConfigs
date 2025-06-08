if [[ ! -x $(command -v curl) ]]; then
    echo "curl is required to run this script!"
    echo "Exiting..."
    exit 1
fi

if [[ ! -x $(command -v wget) ]]; then
    echo "wget is required to run this script!"
    echo "Exiting..."
    exit 1
fi

if [[ ! -x $(command -v fuser) ]]; then
    echo "fuser is required to run .appimage!"
    echo "Exiting..."
    exit 1
fi

BIN_DIR=$HOME/.local/bin
[[ -d $BIN_DIR ]] || mkdir $BIN_DIR

CONFIG_DIR=$HOME/.config
[[ -d $CONFIG_DIR ]] || mkdir $CONFIG_DIR

DOWNLOAD_DIR=$HOME/Downloads
[[ -d $DOWNLOAD_DIR ]] || mkdir $DOWNLOAD_DIR

# 下载并安装二进制包
[[ -x $(command -v starship) ]] || curl -sS https://starship.rs/install.sh | sh -s -- -b $BIN_DIR

if [[ ! -x $(command -v eza) ]]; then
    eza_version=0.21.4
    eza_name=eza_x86_64-unknown-linux-gnu
    wget https://github.com/eza-community/eza/releases/download/v$eza_version/$eza_name.tar.gz -O $DOWNLOAD_DIR/$eza_name.tar.gz
    tar -zxf $DOWNLOAD_DIR/$eza_name.tar.gz -C $BIN_DIR
fi

if [[ ! -x $(command -v fd) ]]; then
    fd_version=10.2.0
    fd_name=fd-v$fd_version-x86_64-unknown-linux-gnu
    wget https://github.com/sharkdp/fd/releases/download/v$fd_version/$fd_name.tar.gz -O $DOWNLOAD_DIR/$fd_name.tar.gz
    tar -zxf $DOWNLOAD_DIR/$fd_name.tar.gz -C $DOWNLOAD_DIR
    mv $DOWNLOAD_DIR/$fd_name/fd $BIN_DIR
fi

if [[ ! -x $(command -v fzf) ]]; then
    fzf_version=0.62.0
    fzf_name=fzf-$fzf_version-linux_amd64
    wget https://github.com/junegunn/fzf/releases/download/v$fzf_version/$fzf_name.tar.gz -O $DOWNLOAD_DIR/$fzf_name.tar.gz
    tar -zxf $DOWNLOAD_DIR/$fzf_name.tar.gz -C $DOWNLOAD_DIR
    mv $DOWNLOAD_DIR/fzf $BIN_DIR
fi

if [[ ! -x $(command -v jq) ]]; then
    jq_version=1.8.0
    wget https://github.com/jqlang/jq/releases/download/jq-$jq_version/jq-linux-amd64 -O $BIN_DIR/jq
    chmod u+x $BIN_DIR/jq
fi

if [[ ! -x $(command -v lazygit) ]]; then
    lg_version=0.52.0
    lg_name=lazygit_${lg_version}_Linux_x86_64
    wget https://github.com/jesseduffield/lazygit/releases/download/v$lg_version/$lg_name.tar.gz -O $DOWNLOAD_DIR/$lg_name.tar.gz
    mkdir $DOWNLOAD_DIR/$lg_name
    tar -zxf $DOWNLOAD_DIR/$lg_name.tar.gz -C $DOWNLOAD_DIR/$lg_name
    mv $DOWNLOAD_DIR/$lg_name/lazygit $BIN_DIR
fi

if [[ ! -x $(command -v nvim) ]]; then
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage -O $BIN_DIR/nvim
    chmod u+x $BIN_DIR/nvim
fi

if [[ ! -x $(command -v rg) ]]; then
    rg_version=14.1.1
    rg_name=ripgrep-$rg_version-x86_64-unknown-linux-musl
    wget https://github.com/BurntSushi/ripgrep/releases/download/$rg_version/$rg_name.tar.gz -O $DOWNLOAD_DIR/$rg_name.tar.gz
    tar -zxf $DOWNLOAD_DIR/$rg_name.tar.gz -C $DOWNLOAD_DIR
    mv $DOWNLOAD_DIR/$rg_name/rg $BIN_DIR
fi

if [[ ! -x $(command -v tmux) ]]; then
    tmux_version=3.5a
    wget https://github.com/nelsonenzo/tmux-appimage/releases/download/$tmux_version/tmux.appimage -O $BIN_DIR/tmux
    chmod u+x $BIN_DIR/tmux
fi

if [[ ! -x $(command -v yazi) ]]; then
    yazi_version=25.5.31
    yazi_name=yazi-x86_64-unknown-linux-musl
    wget https://github.com/sxyazi/yazi/releases/download/v$yazi_version/$yazi_name.zip -O $DOWNLOAD_DIR/$yazi_name.zip
    unzip $DOWNLOAD_DIR/$yazi_name.zip -d $DOWNLOAD_DIR
    mv $DOWNLOAD_DIR/$yazi_name/ya $BIN_DIR
    mv $DOWNLOAD_DIR/$yazi_name/yazi $BIN_DIR
fi

if [[ ! -x $(command -v yq) ]]; then
    yq_version=4.45.4
    wget https://github.com/mikefarah/yq/releases/download/v$yq_version/yq_linux_amd64 -O $BIN_DIR/yq
    chmod u+x $BIN_DIR/yq
fi

# 建立软链接
[[ -f $HOME/.bash_profile ]] || ln -s $HOME/THConfigs/.bash_profile $HOME
[[ -d $CONFIG_DIR/lazygit ]] || ln -s $HOME/THConfigs/lazygit $CONFIG_DIR/lazygit
[[ -d $CONFIG_DIR/nvim ]] || ln -s $HOME/THConfigs/nvim $CONFIG_DIR/nvim
[[ -f $CONFIG_DIR/starship.toml ]] || ln -s $HOME/THConfigs/starship.toml $HOME/.config/
[[ -f $HOME/.tmux.conf ]] || ln -s $HOME/THConfigs/.tmux.conf $HOME
[[ -d $CONFIG_DIR/yazi ]] || ln -s $HOME/THConfigs/yazi $CONFIG_DIR/yazi

if [[ "$(rg 'source \$HOME/THConfigs/utils.sh' $HOME/.bashrc)" == "" ]]; then
    echo -e '\n# Automatically added by ~/THConfigs/setup.sh' >> $HOME/.bashrc
    echo 'source $HOME/THConfigs/utils.sh' >> $HOME/.bashrc
fi
source $HOME/.bashrc
