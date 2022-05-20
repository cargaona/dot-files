# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export CODE_PATH=$HOME/projects/personal/code
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="minimal-char"
MNML_PROMPT=(mnml_ssh mnml_pyenv mnml_status mnml_keymap 'mnml_cwd 2 0' mnml_git) 
MNML_RPROMPT=()

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
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

bindkey -M menuselect '^[[Z' reverse-menu-complete

if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi

 
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
#
#        autoload -U compinit && compinit -u

#if [[ "$OSTYPE" == "linux-gnu"* ]]; then
if [[ $(hostname) != "raspi" && "$OSTYPE" != "darwin20.0" ]]; then
    autoload -U compinit && compinit
    source $CODE_PATH/kube-ps1/kube-ps1.sh
    export KUBE_PS1_SYMBOL_ENABLE=false 
    PROMPT='$(kube_ps1)'$PROMPT
    kubeoff
fi 
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias cd..="cd .."
alias google-chrome=google-chrome-stable
alias grip="history | grep"
alias vim=nvim
alias g=git 
alias gdl='git diff $(git rev-parse HEAD)'
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

alias kctx=kubectx
alias k=kubectl
alias kon=kubeon
alias kof=kubeoff 
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
#export PATH=$PATH:/usr/local/tinygo/bin
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye > /dev/null
#. /usr/share/autojump/autojump.sh

#if [[ "$OSTYPE" == "darwin20.0" ]]; then
#    PATH=$PATH:/usr/local/MacGPG2/bin/
#    export GPG_TTY="$(tty)"
#    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#    gpgconf --launch gpg-agent
#fi


# The next line enables shell command completion for gcloud.
if [ -f '/home/char/projects/personal/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/char/projects/personal/code/google-cloud-sdk/completion.zsh.inc'; fi
