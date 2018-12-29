export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/blackcat/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(
  git
  tmux
  vscode
)

source $ZSH/oh-my-zsh.sh

# User configuration

export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Go
export GOPATH=$HOME/go

# Alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias ll='ls -alF'
alias fuck='sudo $(history -p \!\!)'
alias ssh_socks_proxy='ssh -D 8888  -f -N'
alias tmux="env TERM=screen-256color tmux"
alias git_sync_with_upstream="git fetch upstream && git checkout master && git rebase upstream/master"
