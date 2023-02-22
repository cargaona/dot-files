plugins=(git
        kube-ps1
        vi-mode
        autojump)

# TODO: is this still needed?
function _ssh_agent () {
  ## Starts the ssh-agent and set the envvar for tmux
  [ ! -f ~/.ssh.agent ] && ssh-agent -s >~/.ssh.agent
  eval `cat ~/.ssh.agent` >/dev/null
  if ! kill -0 $SSH_AGENT_PID 2>/dev/null; then
    ssh-agent -s >~/.ssh.agent
    eval `cat ~/.ssh.agent` >/dev/null
  fi
}
# bindkey -M menuselect '^[[Z' reverse-menu-complete

# TODO: is this still needed?
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

function _set_alias () {
  alias cd..="cd .."
  alias google-chrome=google-chrome-stable
  alias grip="history | grep"
  alias vim=nvim
  alias vf='vim $(fzf)'

  alias g=git 
  alias ga='git add .'
  alias gdl='git diff $(git rev-parse HEAD)'
  alias gdc='git diff --cached'
  alias gir=git ## You know this feeling. 
  alias gcm="git commit -m "
  alias gcma="git commit --amend"

  alias netk="sudo systemctl restart NetworkManager"
  alias python=python3
  alias venv=virtualenv
  alias tl="tmux list-sessions"
  alias ta="tmux attach-session -t"
  alias t="ta || tmux"
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
}

function _theme () {
  ZSH_THEME="minimal-char"
  MNML_PROMPT=(mnml_ssh mnml_pyenv kube_ps1 mnml_status mnml_keymap 'mnml_cwd 2 0' mnml_git) 
  MNML_RPROMPT=()
  export ZSH="$HOME/.oh-my-zsh"
  source $ZSH/oh-my-zsh.sh
}

function _env_vars () {
  export CODE_PATH="$HOME/projects/personal/code" 
  export KUBE_PS1_SYMBOL_ENABLE=false
  # Uncomment the following line to enable command auto-correction.
  ENABLE_CORRECTION="false"
  
  # Uncomment the following line to display red dots whilst waiting for completion.
  COMPLETION_WAITING_DOTS="true"
  export EDITOR=nvim
  export HISTCONTROL=ignoreboth:erasedups
  export XDG_CONFIG_DIRS=$HOME/.config 
  export RTV_BROWSER=firefox
}

function _set_path () {
  export PATH=$HOME/.local/bin:$PATH
  export PATH=$CODE_PATH/dot-files/scripts/:$PATH
  #export GOROOT=/usr/bin/go
  export GOPATH=$CODE_PATH/go
  export PATH=$GOPATH/bin:$PATH
}

function _linux_gpg () {
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  gpg-connect-agent updatestartuptty /bye > /dev/null
}

function _start_raspi () {
  if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] ; then
    startx
  fi
} 

function _mac_gpg () {
  PATH=$PATH:/opt/homebrew/bin/
  PATH=$PATH:/usr/local/MacGPG2/bin/
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
}

function _is_mac () {
  [[ "$OSTYPE" == "darwin20.0" || "$OSTYPE" == "darwin21.0" ]]
}

function _is_raspi () {
  [[ $(hostname) = "raspi" ]]
}

function _remove_duplicates_from_path {
  PATH=$(echo $(sed 's/:/\n/g' <<< $PATH | sort | uniq) | sed -e 's/\s/':'/g')
} 

# start
_theme
_set_alias
_env_vars
_set_path
_ssh_agent

if _is_mac ; then
  echo "Hi :wave: I'm a mac computer. I'm inferior"
  _mac_gpg
else
  echo "Hi :wave: I'm a linux computer. I'm superior"
  _linux_gpg
  _remove_duplicates_from_path
  kubeoff
fi

if _is_raspi ; then
  _start_raspi
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi
