# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export CODE_PATH=$HOME/projects/personal/code

ZSH_THEME="minimal-char"
MNML_PROMPT=(mnml_ssh mnml_pyenv kube_ps1 mnml_status mnml_keymap 'mnml_cwd 2 0' mnml_git) 
MNML_RPROMPT=()
export KUBE_PS1_SYMBOL_ENABLE=false

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git
        kube-ps1
        vi-mode
        autojump)

source $ZSH/oh-my-zsh.sh

## Starts the ssh-agent and set the envvar for tmux
[ ! -f ~/.ssh.agent ] && ssh-agent -s >~/.ssh.agent
eval `cat ~/.ssh.agent` >/dev/null
if ! kill -0 $SSH_AGENT_PID 2>/dev/null; then
        ssh-agent -s >~/.ssh.agent
        eval `cat ~/.ssh.agent` >/dev/null
fi

# bindkey -M menuselect '^[[Z' reverse-menu-complete

if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# You may need to manually set your language environment
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

alias cd..="cd .."
alias google-chrome=google-chrome-stable
alias grip="history | grep"
alias vim=nvim

alias g=git 
alias ga='git add .'
alias gdl='git diff $(git rev-parse HEAD)'
alias gdc='git diff --cached'
alias gir=git ## You know this feeling. 
alias gcm="git commit -m "


alias netk="sudo systemctl restart NetworkManager"
alias python=python3
alias venv=virtualenv
alias tl="tmux list-sessions"
alias ta="tmux attach-session -t"
alias cdr='cd $(git rev-parse --show-toplevel)'
alias copy='xclip -sel clip'
alias .z="source ~/.zshrc"
#alias bat="batcat"
alias bt=bluetoothctl
alias btoff="bluetoothctl power off"
alias bton="bluetoothctl power on"

alias ac="aws sts get-caller-identity"
alias kctx=kubectx
alias k=kubectl
alias kon=kubeon
alias koff=kubeoff 
alias kns=kubens
alias kneat=kubectl-neat
alias tf=terraform 
alias dk=docker

export EDITOR=nvim
export HISTCONTROL=ignoreboth:erasedups
export XDG_CONFIG_DIRS=$HOME/.config 
export RTV_BROWSER=firefox

export PATH=$HOME/.local/bin:$PATH
#export GOROOT=/usr/bin/go
export GOPATH=$HOME/go
export PATH=$PATH:$CODE_PATH/google-cloud-sdk/bin
#export PATH=$GOPATH/bin:$PATH


## GPG Setup 
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
#. /usr/share/autojump/autojump.sh

if [[ "$OSTYPE" == "darwin20.0" || "$OSTYPE" == "darwin21.0" ]]; then
    PATH=$PATH:/opt/homebrew/bin/
    PATH=$PATH:/usr/local/MacGPG2/bin/
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
fi

gpg-connect-agent updatestartuptty /bye > /dev/null

kubeoff
# The next line enables shell command completion for gcloud.
if [ -f '/home/char/projects/personal/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/char/projects/personal/code/google-cloud-sdk/completion.zsh.inc'; fi
