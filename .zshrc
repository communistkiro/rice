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
# DISABLE_MAGIC_FUNCTIONS=true

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
  # timer 
)
# TIMER_PRECISION=6

autoload -U +X compinit && compinit 
autoload -U +X bashcompinit && bashcompinit

source $ZSH/oh-my-zsh.sh

setopt EXTENDED_GLOB KSH_GLOB NO_SH_GLOB
# REMATCH_PCRE

# STACK TAB-AUTOCOMPLETION
# https://docs.haskellstack.org/en/stable/shell_autocompletion/
# eval "$(stack --bash-completion-script stack)"


# ALII
# UTILITIES
alias vol='amixer set Master'
alias xb='xbacklight -set'
alias so='source /root/.zshrc'
alias mix='amixer set Beep 0; amixer sset Capture toggle; xbacklight -set 20'
# PROGRAMS AND PREFERENCES
alias xbq='xbps-query --regex -Rs'
alias xbqm='xbps-query -m'
alias xbql='xbps-query -l'
alias xbs='xbps-install -Su'
alias xbr='xbps-remove -R'
alias ls='lsd -A'
alias ls1='lsd -A1'
alias lsr='lsd -A --tree'
alias less='less --ignore-case --LONG-PROMPT --tabs 4'
alias du='/bin/du -hs'
alias rm='sudo rm -r'
alias cp='cp -vR'
alias gre='/bin/grep -P --color -i'
alias pre='pcre2grep -i --color'
alias man='man -a -T ascii -O width=94,indent=2'
alias catdoc='catdoc -m256'
alias pk='pkill -KILL -i'
alias rsync='rsync -vah --progress'
alias ncm='ncmpcpp'
alias mpdd='pgrep mpd &>/dev/null && pk mpd && sleep 5 && mpdd || mpd && mpdas -d && ncm'
alias feh='feh --scale-down'
alias cmat='cmatrix -au2'
alias kl='khal interactive'
alias kln='khal new'
alias mpv='mpv --gpu-dumb-mode=yes'
# alias ww='wyrd'
# alias ww='when --past=0 --future=1'
# alias we='when e'
alias rr='ranger --cmd="chain set preview_files true"'
alias hl='hledger-ui --watch'
alias cow='cowthink -e "^^" -f xxx -T "U"'
alias sex='sex | cow'
alias f1='/bin/fortune | cow'
alias f2='/bin/fortune de | cow'
alias f3='/bin/fortune void | cow'
alias oc='octave-cli'
alias oce='octave-cli --eval'
alias espeak='espeak -p30 -k35 -s310 -g 2 -ven-sc'
alias flite='flite -voice awb'
alias loc='setxkbmap us; export LANG=en_US.UTF-8; xb 0; slock; xb 12'
alias snow='pkill xsnow ; xsnow -snowflakes 1000 -santaspeed 15 -santa 1 -santaupdatefactor 1 -notrees -whirl 180 -yspeed 222 -xspeed 88 & disown'
alias ff='firefox &>/dev/null & disown'
alias vsc='code-oss --user-data-dir ~/vsc/'
alias bl='subl3'
alias bll='subl3 -n --command toggle_side_bar -a'
alias qpp='qpdfview --unique &> /dev/null & disown'
alias mpi='mp3info2'
alias 16t='mpv --no-audio-pitch-correction'
alias 16tons='16t /media/ELEM/Music/Random/Sixteen\ Tons\ -\ Tennessee\ Ernie\ Ford.m4a'
alias bustin='16t /media/ELEM/Music/N/Neil\ Cicierega/Neil\ Cicierega\ \[Mouth\ Moods\ \(2017\)\]/08\ Bustin.mp3'
alias lmms='lmms --allowroot &>/dev/null & disown'
alias ffff="echo fuck | skroll -rl -d .0025 -n 33"
alias clb="col -b"
alias bb='bye'
# alias npp='notepadqq --allow-root 2> /dev/null & disown'
alias unb='bindkey -d'
alias mle='mle -i1 -w1'
alias love='mpc sendmessage mpdas love'
alias unlove='mpc sendmessage mpdas unlove'
alias mss='st -n "sweaper" -f "Monofurbold Nerd Font:pixelsize=36" & disown ; exit'
alias ms1='tmines -fd22; clear'
alias ms='ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1; ms1'
alias cata='~/games/cataclysmdda-0.E/cataclysm-launcher &>/dev/null & disown'
alias tetris='/root/games/NullpoMino7_5_0/play_slick >& /dev/null & disown'
alias tome='cd /root/games/t-engine4-linux64-1.6.7; ./t-engine & disown'
alias fzf='fzf -m\
  --bind "alt-e:execute(subl3 -n --command toggle_side_bar -a {+})"\
  --bind "alt-r:execute(micro {+})"\
  --bind "alt-f:clear-selection"\
  --bind "alt-v:select-all"'
alias sf="tabbed -p s+1 -dr 2 surf -e '' &> /dev/null & disown"
alias dlwiki="wget --recursive --html-extension --page-requisites --no-parent --convert-links --no-check-certificate" 
alias fd='fd -uu -i'
alias d2ra='cd /root/.wine/drive_c/D2-plugy-base-randomizer; wine Game.exe -w -direct -txt -ddraw -direct -txt &>/dev/null & disown'
alias d2re='cd /root/.wine/drive_c/D2-resurgence; wine Plugy.exe &>/dev/null & disown'

# FUNCTIONS
fpath=(/root/.config/zsh/autoloadmedaddy $fpath)
autoload $(ls /root/.config/zsh/autoloadmedaddy) zmv


# SOURCE
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# . ~/.config/zkbd$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
bindkey '\' forward-char
# bindkey ';' backward-char
