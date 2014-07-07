# autoload omz
# zstyle :omz:style theme default
# plugins=(archlinux sprunge git)
# omz init

bindkey -v
ZSH=$HOME/.oh-my-zsh
#~/.oh-my-zsh/themes/rykka.zsh-theme
ZSH_THEME="kolo"           # ~/.oh-my-zsh/themes/
# plugins=(git archlinux django github)
source $ZSH/oh-my-zsh.sh

#######################################################################
#             Customization by User
#######################################################################
backward-delete-to-slash () {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}
zle -N backward-delete-to-slash
bindkey '^[w' backward-delete-to-slash
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
bindkey -v
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line

bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^K" kill-line  
bindkey "^U" backward-kill-line 

bindkey "^X" vi-cmd-mode  
bindkey "^B" history-beginning-search-backward
bindkey "^F" history-beginning-search-forward
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history


# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-beginning-search-backward 
bindkey '^[[B' history-beginning-search-forward 

setopt auto_cd

export EDITOR='gvim'


# Proxy Tools
alias -g ssh1='sh -c ~/Documents/Scripts/sshgfw.sh'
alias -g ssh2='sh -c ~/Documents/Scripts/sshgfw2.sh'
alias -g sshp='ssh -D 7070 ryk@xehost0'
alias -g gae='python2 ~/Documents/net/goagent/local/proxy.py'
alias -g goae='python2 /opt/goagent/local/proxy.py'
alias -g wpx='python2 ~/Documents/net/wallproxy-plus/local/startup.py'
alias -g ovpn='sudo openvpn --script-security 2 --config ~/ovpn-client/client.conf'


alias -g cp='cp'
alias -g mv='mv'
alias -g rm='rm'
alias -g ls='ls -F --color=always'
alias -g lc='ls -F --color=always'
alias -g ll='ls -l -h'
alias -g lsg='ls -l | grep --color=auto'
alias -g grep='grep --color=auto'
alias -g psg='ps aux | grep --color=auto'
alias -g lsg='ls -a | grep --color=auto'
alias -g gvimr='gvim --remote-tab'
alias -g ee='emacsclient -t'
alias -g mp='./manage.py'
alias -g :e='vim'
alias -g na='nautilus `pwd`'
alias -g vact='source bin/activate'
alias -g vdac='deactivate'
alias -g dja='django-admin.py '
alias -g sencha='/home/ryk/bin/Sencha/Cmd/4.0.1.45/sencha'

alias -g lrc='~/.scripts/lrcdis -m echo >! /tmp/lrc &'
alias -g klrc='pkill lrcdis'


# Django
alias -g djm='python manage.py '
alias -g djmr='python manage.py runserver 8080'
alias -g djmsa='python manage.py schemamigration --auto'
alias -g djmsi='python manage.py schemamigration --initial'
alias -g dja='django-admin.py '


# Project
alias -g gga='git add .'
alias -g ggc='git commit -m '
alias -g ggp='git push'
alias -g fad='fab deploy'

alias bower='noglob bower'

IEM="$HOME/gitplace/lesscolor/iem"
VER="v5"
IEM_CSS_DIR="$IEM/themes/$VER/static/css"
IEM_LESS="$IEM_CSS_DIR/aimi.less"
IEM_CSS="$IEM_CSS_DIR/aimi.css"
IEM_JS_DIR="$IEM/themes/$VER/static/js"
IEM_JS="$IEM_JS_DIR/aimi.coffee"

function update_site() {
    coffee -c $IEM_JS
    lessc $IEM_LESS $IEM_CSS
    git add .
    echo "Input Your Git Message:"
    read git_message
    if [ -z $git_message ] 
        then
        git commit -m '- tmp'
    else
        git commit -m "$git_message"
    fi
    git push 
    fab deploy
}
alias -g gco="coffee -c $IEM_JS && lessc $IEM_LESS > $IEM_CSS"
alias -g ggqi="update_site"

stty -ixon


# Set up auto extension stuff
alias -s html=$BROWSER
# alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

PATH=$PATH:~/.gem/ruby/1.9.1/bin/:~/bin:/local/usr/bin:~/Tools/Android/sdk/tools/:~/Tools/Android/sdk/platform-tools/:/usr/lib/jvm/java-7-openjdk-amd64/bin:~/Tools/Android/eclipse

# Installed java in ubuntu 64 for android SDK
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export ANT_HOME=/usr/share/ant


# virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/workspace

PATH="$PATH:/opt/vagrant/bin"

if [[ -x /usr/bin/virtualenvwrapper.sh ]] then
    source /usr/bin/virtualenvwrapper.sh
fi

if [[ -x /usr/local/bin/virtualenvwrapper.sh ]] then
    source /usr/local/bin/virtualenvwrapper.sh
fi
# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

# virtualbox usb
VBOX_USB=usbfs
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4 

GOPATH=~/go
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
function aa_power_settings ()
{ 
  sudo bash -c '
    for i in `find /sys/devices -name "bMaxPower"`;
    do
        for ii in `find $i -type f`;
        do
            bd=`dirname $ii`;
            busnum=`cat $bd/busnum`;
            devnum=`cat $bd/devnum`;
            title=`lsusb -s $busnum:$devnum`;
            echo -e "\n\n+++ $title\n  -$bd\n  -$ii";
            for ff in `find $bd/power -type f ! -empty 2>/dev/null`;
            do
                v=`cat $ff 2>/dev/null|tr -d "\n"`;
                [[ ${#v} -gt 0 ]] && echo -e " `basename $ff`=$v";
                v=;
            done | sort -g;
        done;
    done;
    echo -e "\n\n\n+++ Kernel Modules\n";
    for m in `command lspci -k|sed -n "/in use:/s,^.*: ,,p"|sort -u`;
    do
        echo "+ $m";
        systool -v -m $m 2> /dev/null | sed -n "/Parameters:/,/^$/p";
    done
  ';
}

[[ -n $DISPLAY ]] && [[ $TERM != "screen" ]] && [[ -z $TMUX ]] && tmux && exit


# # TMUX
# if which tmux 2>&1 >/dev/null; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     test -z "$TMUX" && (tmux attach || tmux new-session)
# fi
# # TMUX
# if which tmux 2>&1 >/dev/null; then
#     # if no session is started, start a new session
#     test -z ${TMUX} && tmux
# 
#     # when quitting tmux, try to attach
#     while test -z ${TMUX}; do
#         tmux attach || break
#     done
# fi
# if which tmux 2>&1 >/dev/null; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     # test -z "$TMUX" && (tmux attach || tmux new-session)
# fi
function rsc() {
  CLIENTID=$1.`date +%S`
  tmux new-session -d -t $1 -s $CLIENTID \; set-option destroy-unattached \; attach-session -t $CLIENTID
}

function mksc() {
  tmux new-session -d -s $1
  rsc $1
}

