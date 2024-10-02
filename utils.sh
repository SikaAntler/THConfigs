# ==================aliases begin==================

# ls & grep
alias grep="grep --color=auto"
if command -v eza &>/dev/null; then
    alias ls="eza"
    alias la="ls -aF"
    alias ll="ls -laF"
    
    alias cnf="ls -1f | wc -l | xargs"
    alias cnfr="ls -1Rf | grep -v '^\.' | grep -v '^$' | wc -l | xargs"
    alias cnd="ls -1D | wc -l | xargs"
else
    alias ls="ls --color=auto"
    alias la="ls -AF"
    alias ll="ls -lAF"

    alias lg="ls -l | grep"
    alias cnd="ls -l | grep '^d' -c"
    alias cnf="ls -l | grep '^-' -c"
    alias cnfr="ls -lR | grep '^-' -c"
fi

# cd
alias ..="cd ../"
alias cd2="cd ../../"
alias cd3="cd ../../../"
alias cd4="cd ../../../../"

# (neo)vim
alias nv="nvim"
alias nb="nvim ~/.bashrc"
alias nz="nvim ~/.zshrc"

# git
alias gs="git status"

# source
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"

# conda
alias act="conda activate"

# tmux
alias tls="tmux ls"
alias tn="tmux new-session -s"
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"
alias tnt="tn train"
alias tat="ta train"
alias tkt="tk train"

# nvidia
alias ns="nvidia-smi"
alias wns="watch -n 1 -d nvidia-smi"
alias C0="CUDA_VISIBLE_DEVICES=0"
alias C1="CUDA_VISIBLE_DEVICES=1"
alias C2="CUDA_VISIBLE_DEVICES=2"
alias C3="CUDA_VISIBLE_DEVICES=3"

# ==================aliases end==================

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
