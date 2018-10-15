alias up='source ~/.bashrc'
alias rc='vim ~/.bashrc'
alias fuck='sudo $(history -p \!\!)'
alias ssh_socks_proxy='ssh -D 8888  -f -N'
alias tmux="env TERM=screen-256color tmux"
alias git_sync_with_upstream="git fetch upstream && git checkout master && git merge upstream/master"
alias vim=nvim
alias vi=vim
alias ldd=otool -L
