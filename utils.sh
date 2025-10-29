# ╭───────────────────────────────────────────────╮
# │                      Env                      │
# ╰───────────────────────────────────────────────╯

# config
export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# editor
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# shell history
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# ╭───────────────────────────────────────────────╮
# │                    Aliases                    │
# ╰───────────────────────────────────────────────╯

# avoid override
alias mv="mv -i"
alias cp="cp -i"

# cd
alias ..="cd ../"
alias cd2="cd ../../"
alias cd3="cd ../../../"
alias cd4="cd ../../../../"

# conda
alias act="conda activate"
alias deact="conda deactivate"

# git
alias lg="lazygit"
alias gs="git status"

# ls & grep
alias grep="grep --color=auto"
if [[ -x $(command -v eza) ]]; then
    alias ls="eza --icons"
    alias l="eza --icons --sort Name"
    alias la="eza --icons --sort Name --all"
    alias ll="eza --icons --sort Name --all --long"

    alias lr="eza --sort Name --all --long | grep -i"
    alias cnf="eza --oneline --only-files | wc -l"
    alias cnfr="eza --oneline --only-files --recurse | grep -v '^\.' | grep -v '^$' | wc -l"
    alias cnd="eza --oneline --only-dirs | wc -l"
else
    alias ls="ls --color=auto"
    alias la="ls -AF"
    alias ll="ls -lAF"

    alias lr="ll | grep"
    alias cnd="ls -l | grep '^d' -c"
    alias cnf="ls -l | grep '^-' -c"
    alias cnfr="ls -lR | grep '^-' -c"
fi

# monitor
alias bt="btop"
alias nt="uvx nvitop --colorful"
alias ns="nvidia-smi"
alias wns="watch -n 1 -d nvidia-smi"

# neovim
alias nb="nvim ~/.bashrc"
alias nz="nvim ~/.zshrc"

# source
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"

# tmux
alias tls="tmux ls"
alias tn='tmux new-session -c $HOME -s'
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"
alias tks="tmux kill-server"
alias tnm="tn main"
alias tam="ta main"
alias tkm="tk main"

# zellij
alias za="zellij attach"
alias zam="zellij attach main"

# ╭───────────────────────────────────────────────╮
# │                  Commands                     │
# ╰───────────────────────────────────────────────╯

# fzf
if [[ -x $(command -v fzf) ]]; then
    if [[ "$SHELL" == */bash ]]; then
        eval "$(fzf --bash)"
    elif [[ "$SHELL" == */zsh ]]; then
        source <(fzf --zsh)
    else
        echo "Shell is not Bash or Zsh"
    fi

    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
    --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
    --color=selected-bg:#494d64 \
    --multi"
fi

# starship
if [[ -x $(command -v starship) ]]; then
    if [[ "$SHELL" == */bash  ]]; then
        eval "$(starship init bash)"
    elif [[ "$SHELL" == */zsh ]]; then
        eval "$(starship init zsh)"
    else
        echo "Shell is not Bash or Zsh"
    fi
fi

# yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# zoxide
if [[ -x $(command -v zoxide) ]]; then
    if [[ "$SHELL" == */bash ]]; then
        eval "$(zoxide init bash)"
    elif [[ "$SHELL" == */zsh ]]; then
        eval "$(zoxide init zsh)"
    fi
fi
