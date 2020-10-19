export PATH=$PATH:/root/.config/zsh/scripts:/root/bin
# export PS1="%? %d |> "
export PS1="%B%F{red}%?%f %F{cyan}%d%f %F{green}|>%f%b "


####    OPTS
setopt extended_glob ksh_glob no_sh_glob re_match_pcre

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# autoload -Uz bracketed-paste-magic
# autoload -Uz url-quote-magic
# zle -N bracketed-paste bracketed-paste-magic
# zle -N self-insert url-quote-magic

## History command configuration
HISTFILE=/root/.zsh_history
SAVEHIST=10000
HISTSIZE=10000 # cushion large than SAVEHIST, if hist_expire_dups_first set
setopt no_extended_history      # record timestamp of command in HISTFILE
setopt hist_reduce_blanks
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_all_dups     # remove old dupes
# setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
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

# source /root/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /root/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

source /root/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source /root/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# source /root/.config/omz/lib/directories.zsh

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}
compdef _dirs d

# source /root/.config/omz/plugins/timer/timer.plugin.zsh
# TIMER_FORMAT='[%d]'
# TIMER_PRECISION=7


####    ALII
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

alias 16t='mpv --no-audio-pitch-correction'
alias 16tons='16t /media/ELEM/Music/Random/Sixteen\ Tons\ -\ Tennessee\ Ernie\ Ford.m4a'
alias bb='bye'
alias bl='subl3'
alias bll='subl3 -n --command toggle_side_bar -a'
alias bustin='16t /media/ELEM/Music/N/Neil\ Cicierega/Neil\ Cicierega\ \[Mouth\ Moods\ \(2017\)\]/08\ Bustin.mp3'
alias catdoc='catdoc -m ${"$(stty size)"#* }'
alias clock='tty-clock -sbc'
alias cmat='cmatrix -au2'
alias cow='cowthink -e "^^" -f xxx -T "U"'
alias cp='cp -vR'
# alias dlwiki="wget --recursive --html-extension --page-requisites --no-parent --convert-links --no-check-certificate" 
alias du='du -h'
alias fd='fd -uu -i'
alias feeds='sfeed_curses /root/.sfeed/feeds/*'
# alias ffff="echo fuck | skroll -rl -d .0025 -n 33"
alias fltrdr='fltrdr --config "/root/src/fltrdr/config/default"'
alias fread='feed flinks'
alias fzf='fzf -i -m --reverse --border=horizontal \
  --bind "alt-e:execute(subl3 -n --command toggle_side_bar -a {+})" \
  --bind "alt-r:execute(mle {+})" \
  --bind "alt-c:clear-selection" \
  --bind "alt-v:select-all" \
  --bind "ctrl-j:accept"'
alias gre='grep -P --color -i'
alias hl='hledger-ui --watch'
alias l='less -F'
alias l1='lsd -A1'
alias ll='lsd -A'
alias love='mpc sendmessage mpdas love'
alias lr='lsd -A --tree'
alias lread="feed 'lynx -dump' | less"
alias man='man -a'
# alias man="man -O width=${"$(stty size)"#* }"
alias mle='mle -i 1 -w 1 -y syn_generic'
alias mpi='mp3info2'
alias mpva='mpv --force-window=yes'
alias mpvn='mpv --no-video'
alias mpvp='mpv --vo=tct --profiles=sw-fast'
alias mss='st -n "sweaper" -f "Monofurbold Nerd Font:pixelsize=36" &>/dev/null & disown'
alias ncm='ncmpcpp'
alias oc='octave-cli --quiet'
alias oce='octave-cli --quiet --no-history --eval'
alias pk='pkill -KILL -i -x'
alias pre='pcre2grep -i --color'
alias rg='rg --color always --heading --line-number --smart-case --engine auto --hidden --unrestricted'
# alias rm='rm -I'
# alias rdl='rdrview -B lynx $1'
# alias rds='rdrview -B surf $1'
alias rsync='rsync -vah --progress'
alias sex='sex | cow'
# alias snow='pkill xsnow ; xsnow -snowflakes 1000 -santaspeed 15 -santa 1 -santaupdatefactor 1 -notrees -whirl 180 -yspeed 222 -xspeed 88 & disown'
alias so='source /root/.zshrc'
# alias tage='tageditor'
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
alias zcp='zmv -C'
alias zmv='zmv -M'
alias zln='zln -L'


# alias unb='bindkey -d'
# bindkey '\' forward-char
# bindkey '^X\t' complete


####    AUTOLOAD
fpath=(/root/.config/zsh/zsh-completions /root/.config/zsh/autoloadmedaddy $fpath)
autoload $(ls /root/.config/zsh/autoloadmedaddy) zed zmv # zcalc zmathfunc
