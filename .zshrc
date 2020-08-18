export PATH=$PATH:/opt/texlive/2020/bin/x86_64-linux:/root/.config/zsh/scripts:/root/bin
export PS1="%? %d |> "

####    OPTS
setopt EXTENDED_GLOB KSH_GLOB NO_SH_GLOB RE_MATCH_PCRE

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# autoload -Uz bracketed-paste-magic
# autoload -Uz url-quote-magic
# zle -N bracketed-paste bracketed-paste-magic
# zle -N self-insert url-quote-magic

## History command configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
# setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # show command with history expansion to user before running it
setopt share_history            # share command history data

setopt No_Beep                  # no beep

setopt auto_cd                  # don't try to execute directories, change into them

setopt interactivecomments      # all after # ignored


####    PLUGINS
autoload -U compaudit compinit
autoload -U +X compinit && compinit 
autoload -U +X bashcompinit && bashcompinit
autoload -U compdef

source /root/.config/omz/lib/completion.zsh

source /root/.config/omz/plugins/extract/extract.plugin.zsh

FZF_BASE=/root/src/fzf
source /root/.config/omz/plugins/fzf/fzf.plugin.zsh

source /root/.config/zsh/plugins/zsh-colored-man-pages/colored-man-pages.plugin.zsh

# . /root/.config/omz/plugins/timer/timer.plugin.zsh
# TIMER_FORMAT='[%d]'
# TIMER_PRECISION=7

source /root/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /root/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source /root/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# source /root/.config/omz/lib/directories.zsh
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}
compdef _dirs d

####    ALII
alias 16t='mpv --no-audio-pitch-correction'
alias 16tons='16t /media/ELEM/Music/Random/Sixteen\ Tons\ -\ Tennessee\ Ernie\ Ford.m4a'
alias mpva='mpv --force-window=yes'
alias bb='bye'
alias bl='subl3'
alias bll='subl3 -n --command toggle_side_bar -a'
alias bustin='16t /media/ELEM/Music/N/Neil\ Cicierega/Neil\ Cicierega\ \[Mouth\ Moods\ \(2017\)\]/08\ Bustin.mp3'
alias catdoc='catdoc -m256'
# alias ccal='calcurse -q'
# alias clb="col -b"
alias clock='tty-clock -sbc'
alias cmat='cmatrix -au2'
alias cow='cowthink -e "^^" -f xxx -T "U"'
alias cp='cp -vR'
# alias dlwiki="wget --recursive --html-extension --page-requisites --no-parent --convert-links --no-check-certificate" 
alias du='du -h'
alias fd='fd -uu -i'
# alias ffff="echo fuck | skroll -rl -d .0025 -n 33"
alias fltrdr='fltrdr --config "/root/src/fltrdr/config/default"'
alias fread='feed flinks'
alias fzf='fzf -m \
  --bind "alt-e:execute(subl3 -n --command toggle_side_bar -a {+})" \
  --bind "alt-r:execute(mle {+})" \
  --bind "alt-c:clear-selection" \
  --bind "alt-v:select-all" '
alias gre='grep -P --color -i'
alias hl='hledger-ui --watch'
alias l1='lsd -A1'
alias ll='lsd -A'
alias love='mpc sendmessage mpdas love'
alias lr='lsd -A --tree'
alias lread="feed 'lynx -dump' | less"
alias man='man -a'
alias mle='mle -i1 -w1'
alias mpi='mp3info2'
alias mss='st -n "sweaper" -f "Monofurbold Nerd Font:pixelsize=36" &>/dev/null & disown'
alias ncm='ncmpcpp'
alias oc='octave-cli --quiet'
alias oce='octave-cli --quiet --no-history --eval'
alias pk='pkill -KILL -i -x'
alias pre='pcre2grep -i --color'
alias rg='rg --color always --heading --line-number --smart-case --engine auto --hidden --unrestricted'
# alias rm='rm -I'
alias rsync='rsync -vah --progress'
alias sex='sex | cow'
# alias snow='pkill xsnow ; xsnow -snowflakes 1000 -santaspeed 15 -santa 1 -santaupdatefactor 1 -notrees -whirl 180 -yspeed 222 -xspeed 88 & disown'
alias so='source /root/.zshrc'
alias tage='tageditor'
alias unlove='mpc sendmessage mpdas unlove'
alias vol='amixer set Master'
alias xb='xbacklight -set'
alias xbq='xbps-query --regex -Rs'
alias xbql='xbps-query -l'
alias xbqm='xbps-query -m'
alias xbr='xbps-remove -R'
alias xbs='xbps-install -Su'
alias which='which -a'
alias xc='xclip -selection clipboard'
# alias unb='bindkey -d'
# bindkey '\' forward-char
# bindkey ';' backward-char


####    AUTOLOAD
fpath=(/root/.config/zsh/zsh-completions /root/.config/zsh/autoloadmedaddy $fpath)
autoload $(ls /root/.config/zsh/autoloadmedaddy) zmv zcalc zmathfunc
