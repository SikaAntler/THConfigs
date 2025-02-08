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

# rust写的工具可以用cargo安装
[[ -x $(command -v cargo) ]] || curl https://sh.rustup.rs -sSf | sh
[[ -x $(command  -v eza) ]] || cargo install eza 
[[ -x $(command  -v fd) ]] || cargo install fd-find
[[ -x $(command  -v rg) ]] || cargo install ripgrep
[[ -x $(command  -v yazi) ]] || cargo install --locked yazi-fm yazi-cli

# 下载并安装二进制包
[[ -x $(command -v starship) ]] || curl -sS https://starship.rs/install.sh | sh -s -- -b $BIN_DIR

if [[ ! -x $(command -v fzf) ]]; then
    wget https://github.com/junegunn/fzf/releases/download/v0.59.0/fzf-0.59.0-linux_amd64.tar.gz -O $DOWNLOAD_DIR/fzf.tar.gz
    tar -zxf $DOWNLOAD_DIR/fzf.tar.gz -C $DOWNLOAD_DIR
    mv $DOWNLOAD_DIR/fzf $BIN_DIR
fi

if [[ ! -x $(command -v jq) ]]; then
    wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 -O $BIN_DIR/jq
    chmod u+x $BIN_DIR/jq
fi

if [[ ! -x $(command -v lazygit) ]]; then
    wget https://github.com/jesseduffield/lazygit/releases/download/v0.45.2/lazygit_0.45.2_Linux_x86_64.tar.gz -O $DOWNLOAD_DIR/lazygit.tar.gz
    mkdir $DOWNLOAD_DIR/lazygit
    tar -zxf $DOWNLOAD_DIR/lazygit.tar.gz -C $DOWNLOAD_DIR/lazygit
    mv $DOWNLOAD_DIR/lazygit/lazygit $BIN_DIR
fi

if [[ ! -x $(command -v nvim) ]]; then
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage -O $BIN_DIR/nvim
    chmod u+x $BIN_DIR/nvim
fi

if [[ ! -x $(command -v yq) ]]; then
    wget https://github.com/mikefarah/yq/releases/download/v4.45.1/yq_linux_amd64 -O $BIN_DIR/yq
    chmod u+x $BIN_DIR/yq
fi

# 建立软链接
[[ -f $HOME/.bash_profile ]] || ln -s $HOME/THConfigs/.bash_profile $HOME
[[ -d $CONFIG_DIR/lazygit ]] || ln -s $HOME/THConfigs/lazygit $CONFIG_DIR/lazygit
[[ -d $CONFIG_DIR/nvim ]] || ln -s $HOME/THConfigs/nvim $CONFIG_DIR/nvim
[[ -f $CONFIG_DIR/starship.toml ]] || ln -s $HOME/THConfigs/starship.toml $HOME/.config/
[[ -f $HOME/.tmux.conf ]] || ln -s $HOME/THConfigs/.tmux.conf $HOME
[[ -d $CONFIG_DIR/yazi ]] || ln -s $HOME/THConfigs/yazi $CONFIG_DIR/yazi

if [[ "$(rg 'source \$HOME/THConfigs/utils.sh' ~/.bashrc)" == "" ]]; then
    echo -e '\n# Automatically added by ~/THConfigs/setup.sh' >> $HOME/.bashrc
    echo 'source $HOME/THConfigs/utils.sh' >> $HOME/.bashrc
fi
source $HOME/.bashrc
