# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

alias ls='ls --color=auto'
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend                      # append to history, don't overwrite it

#setterm -bfreq 0
export EDITOR=vim

#this fucks up the control+key shortcuts
#set -o vi

source ~/.git-completion.bash
export PS1='\[\033[01;33m\]\w\[\033[01;31m\]$(__git_ps1)\[\033[01;35m\] \$\[\033[00m\] '
if [ $TERM = "screen" ]
then
    # If we're using screen, include <ESC>k<ESC>\
    # in the PS1 so the window title is updated
    # to the current running command.
    # This sequence itself has to be escaped,
    # otherwise commands longer than one line
    # are not displayed correctly.
    export PS1="\[\033k\]\[\033\ \]\[\033[G\]$PS1"
fi

# Change urxvt font size
function fontsize() {
    printf '\33]50;%s\007' "xft:Inconsolata:pixelsize=$1"
}

which rlwrap > /dev/null 2>&1 && alias guile="rlwrap guile"

#source $HOME/.coderc
export TERM=xterm-256color

alias activate='source env/bin/activate'
alias llactivate='. .venv/bin/activate'

alias manage='python manage.py'
alias test='python manage.py test'
alias runserver='python manage.py runserver'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias cout='git checkout'
alias gd='git diff'
alias pull='git pull'
alias push='git push'
alias stash='git stash'

alias gitgone="git fetch -p && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -D"

alias backup='rsync -aAXHv --exclude={"\.*","processing*","go/*","snap*","ResponsivelyApp*","*.desktop"} /home/mari/ /media/mari/Backup/mari/'

alias dc="docker-compose"
complete -F _complete_alias dc
alias dcr="docker-compose run"
complete -F _complete_alias dcr
alias dcrr="docker-compose run --rm"
complete -F _complete_alias dcrr
alias dce="docker-compose exec"
complete -F _complete_alias dce
alias dcu="docker-compose up"
complete -F _complete_alias dcu
alias dcub="docker-compose up --build"
complete -F _complete_alias dcub
alias dcd="docker-compose down"
complete -F _complete_alias dcd
alias dcl="docker-compose logs -f --tail 200"
complete -F _complete_alias dcl
# Docker stuff
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export COMPOSE_HTTP_TIMEOUT=250
export USER_ID=$(id -u)
export USERID=$(id -u)



PATH=/usr/bin/node:$PATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

