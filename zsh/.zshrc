 #TODO: is this still needed?
#function _ssh_agent () {
  ## Starts the ssh-agent and set the envvar for tmux
  #[ ! -f ~/.ssh.agent ] && ssh-agent -s >~/.ssh.agent
  #eval `cat ~/.ssh.agent` >/dev/null
  #if ! kill -0 $SSH_AGENT_PID 2>/dev/null; then
    #ssh-agent -s >~/.ssh.agent
    #eval `cat ~/.ssh.agent` >/dev/null
  #fi
#}
# bindkey -M menuselect '^[[Z' reverse-menu-complete

# TODO: is this still needed?
#if [[ "${terminfo[kcuu1]}" != "" ]]; then
    #autoload -U up-line-or-beginning-search
    #zle -N up-line-or-beginning-search
    #bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
#fi

_change_folder() {
    # if no argument is provided, search from ~ else use argument
    [[ -z $1 ]] && DIR=~ || DIR=$1
    # choose file using rg and fzf
    CHOSEN=$(fd --strip-cwd-prefix --full-path $DIR -H -t d | fzf --preview="exa -s type --icons {}" --bind="ctrl-space:toggle-preview" --preview-window=,30:hidden)

    # quit if no path is selected else cd into the path
    if [[ -z $CHOSEN ]]; then
        echo $CHOSEN
        return 1
    else
        cd "$CHOSEN"
    fi

    # show ls output if dir has less than 61 files
    [[ $(ls | wc -l) -le 60 ]] && (pwd; ls)
    return 0
}

function _set_alias () {
  alias cd..="cd .."
  alias .z="source ~/.zshrc"
  alias grip="history | grep"
  alias hiz="history | cut -c 8- | uniq | fzf | copy"
  alias cf='_change_folder'
  #alias copy='xclip -sel clip'
  #alias bat="batcat"

  alias syu="sudo pacman -Syu"
  alias netk="sudo systemctl restart NetworkManager"

  alias vim=nvim
  alias vf='vim $(fzf)'

  alias tl="tmux list-sessions"
  alias ta="tmux attach-session -t"
  alias t="ta || tmux"

  alias g=git 
  alias ga='git add .'
  alias gdl='git diff $(git rev-parse HEAD)'
  alias gdc='git diff --cached'
  alias gir=git ## You know this feeling. 
  alias gcm="git commit -m "
  alias gca="git commit --amend"
  #alias gcd="gcm $(date --rfc-3339=date)"
  alias cdr='cd $(git rev-parse --show-toplevel)'

  alias bt=bluetoothctl
  alias btoff="bluetoothctl power off"
  alias bton="bluetoothctl power on"

  alias python=python3
  alias venv=virtualenv

  alias ac="aws sts get-caller-identity"

  alias tf=terraform 

  alias k=kubectl
  alias kctx=kubectx
  alias kneat=kubectl-neat
  alias kns=kubens
  alias koff=kubeoff 
  alias kon=kubeon
}

function _theme () {
  #ZSH_THEME="/home/char/projects/personal/code/dot-files/zsh/minimal-char.zsh-theme"
  source "/home/char/projects/personal/code/dot-files/zsh/minimal-char.zsh-theme"
  DISABLE_UNTRACKED_FILES_DIRTY="true"
  MNML_PROMPT=(mnml_ssh mnml_pyenv kube_ps1 mnml_status mnml_keymap 'mnml_cwd 2 0' mnml_git) 
  MNML_RPROMPT=()
  #export ZSH="$HOME/.oh-my-zsh"
  #source $ZSH/oh-my-zsh.sh
}

function _set_cloudflare() {
  sudo sed -i 's/nameserver 192.168.1.135/nameserver 1.1.1.1/g' /etc/resolv.conf
  cat /etc/resolv.conf
}

function _set_keyboard_input_repetition() {
  xset r rate 250 30
}

function _set_keyboard_layout(){
  setxkbmap -layout us -variant altgr-intl &
}

function _env_vars () {
  export CODE_PATH="$HOME/projects/personal/code" 
  export KUBE_PS1_SYMBOL_ENABLE=false
  # Uncomment the following line to enable command auto-correction.
  #ENABLE_CORRECTION="false"
  
  # Uncomment the following line to display red dots whilst waiting for completion.
  COMPLETION_WAITING_DOTS="true"
  export EDITOR=nvim
  export HISTCONTROL=ignoreboth:erasedups
  export XDG_CONFIG_DIRS=$HOME/.config 
  export RTV_BROWSER=firefox
}

#function _set_path () {
  #export PATH=$HOME/.local/bin:$PATH
  #export PATH=$CODE_PATH/dot-files/scripts/:$PATH
  ##export GOROOT=/usr/bin/go
  #export PATH=/home/char/.local/share/gem/ruby/3.0.0/bin:$PATH 
  #export GOPATH=$CODE_PATH/go
  #export PATH=$GOPATH/bin:$PATH
#}

#function _linux_gpg () {
  #export GPG_TTY="$(tty)"
  #export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  #gpg-connect-agent updatestartuptty /bye > /dev/null
#}

#function _start_raspi () {
  #if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] ; then
    #startx
  #fi
#} 

#function _mac_gpg () {
  #PATH=$PATH:/opt/homebrew/bin/
  #PATH=$PATH:/usr/local/MacGPG2/bin/
  #export GPG_TTY="$(tty)"
  #export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  #gpgconf --launch gpg-agent
#}

function _is_mac () {
  [[ "$OSTYPE" == "darwin22.0" || "$OSTYPE" == "darwin23.0" ]]
}

function _is_raspi () {
  [[ $(hostname) = "raspi" ]]
}

#function _remove_duplicates_from_path {
  #PATH=$(echo $(sed 's/:/\n/g' <<< $PATH | sort | uniq) | sed -e 's/\s/':'/g')
#} 

# start
_theme
_env_vars
#_set_path
#_ssh_agent
kubeoff

if _is_mac ; then
  echo "Hi :wave: I'm a mac computer. I'm inferior"
  alias copy=pbcopy
  _mac_gpg
else
  echo "Hi :wave: I'm a linux computer. I'm superior"
  #_linux_gpg
  #_remove_duplicates_from_path
  alias copy='copyq copy -'
  #_set_keyboard_input_repetition
fi

if _is_raspi ; then
  _start_raspi
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi

_set_alias


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cgaona/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cgaona/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cgaona/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cgaona/google-cloud-sdk/completion.zsh.inc'; fi
