# If you come from bash you might have to change your $PATH.
export PATH=$PATH:/opt/texlive/2020/bin/x86_64-linux:/root/.config/zsh/scripts:$HOME/bin # /usr/local/plan9/bin:

# Path to your oh-my-zsh installation.
export ZSH=/root/.config/omz

# ZSH_THEME=""
source /root/.config/zsh/prompts/qqq

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  extract
  colored-man-pages
  colorize
  fzf
  # timer 
)

# TIMER_PRECISION=6

export FZF_BASE=/root/src/fzf

autoload -U +X compinit && compinit 
autoload -U +X bashcompinit && bashcompinit

source $ZSH/oh-my-zsh.sh

setopt EXTENDED_GLOB KSH_GLOB NO_SH_GLOB RE_MATCH_PCRE

# ALII
alias 16t='mpv --no-audio-pitch-correction'
alias 16tons='16t /media/ELEM/Music/Random/Sixteen\ Tons\ -\ Tennessee\ Ernie\ Ford.m4a'
alias abook='mpv --force-window=yes'
alias bb='bye'
alias bl='subl3'
alias bll='subl3 -n --command toggle_side_bar -a'
alias bustin='16t /media/ELEM/Music/N/Neil\ Cicierega/Neil\ Cicierega\ \[Mouth\ Moods\ \(2017\)\]/08\ Bustin.mp3'
alias catdoc='catdoc -m256'
alias ccal='calcurse -q'
alias clb="col -b"
alias cmat='cmatrix -au2'
alias cow='cowthink -e "^^" -f xxx -T "U"'
alias cp='cp -vR'
alias dlwiki="wget --recursive --html-extension --page-requisites --no-parent --convert-links --no-check-certificate" 
alias du='/bin/du -hs'
alias espeak='espeak -p30 -k35 -s310 -g 2 -ven-sc'
alias fd='fd -uu -i'
alias ff='firefox &>/dev/null & disown'
alias ffff="echo fuck | skroll -rl -d .0025 -n 33"
alias flite='flite -voice awb'
alias fort='/bin/fortune | cow'
alias fread='feed flinks'
alias lread="feed 'lynx -dump' | less"
alias fzf='fzf -m \
  --bind "alt-e:execute(subl3 -n --command toggle_side_bar -a {+})" \
  --bind "alt-r:execute(mle {+})" \
  --bind "alt-f:clear-selection" \
  --bind "alt-v:select-all" '
alias gre='grep -P --color -i'
alias hl='hledger-ui --watch'
alias kl='khal interactive'
alias kln='khal new'
alias l1='lsd -A1'
alias ll='lsd -A'
alias love='mpc sendmessage mpdas love'
alias lr='lsd -A --tree'
alias man='man -a'
alias mle='mle -i1 -w1'
alias mpdd='pgrep mpd &>/dev/null && pk mpd && sleep 5 && mpdd || mpd && mpdas -d && ncm'
alias mpi='mp3info2'
alias mss='st -n "sweaper" -f "Monofurbold Nerd Font:pixelsize=36" &>/dev/null & disown'
alias ncm='ncmpcpp'
alias oc='octave-cli'
alias oce='octave-cli --eval'
alias pk='pkill -KILL -i'
alias pre='pcre2grep -i --color'
alias rm='sudo rm -r'
alias rr='ranger --cmd="chain set preview_files true"'
alias rsync='rsync -vah --progress'
alias sex='sex | cow'
alias snow='pkill xsnow ; xsnow -snowflakes 1000 -santaspeed 15 -santa 1 -santaupdatefactor 1 -notrees -whirl 180 -yspeed 222 -xspeed 88 & disown'
alias so='source /root/.zshrc'
alias tage='tageditor --no-sandbox'
alias tetris='/root/games/NullpoMino7_5_0/play_slick &>/dev/null & disown'
alias tome='cd /root/games/t-engine4-linux64-1.6.7; ./t-engine & disown'
# alias unb='bindkey -d'
alias unlove='mpc sendmessage mpdas unlove'
alias vol='amixer set Master'
alias vsc='sudo --user=v code-oss --user-data-dir ~/vsc/'
alias xb='xbacklight -set'
alias xbq='xbps-query --regex -Rs'
alias xbql='xbps-query -l'
alias xbqm='xbps-query -m'
alias xbr='xbps-remove -R'
alias xbs='xbps-install -Su'
alias xc='xclip -selection clipboard'

# bindkey '\' forward-char
# bindkey ';' backward-char

# FUNCTIONS
fpath=(/root/.config/zsh/autoloadmedaddy $fpath)
autoload $(ls /root/.config/zsh/autoloadmedaddy) zmv zcalc zmathfunc

# wget -P /root/.surf/script/ https://www.4chan-x.net/builds/4chan-X.user.js

# SOURCE
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
