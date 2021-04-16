# export PATH=$PATH:/root/.config/zsh/scripts:/root/bin;
export PATH=${(j : )${(u)${(s : )$(<<<${PATH}:/root/.config/zsh/scripts:/root/bin)}}}
export PS1="%B%F{red}%?%f %F{blue}%d%f%b
";
preexec () { printf '%b' "\e]0;$2\a" }
precmd () { printf '%b' "\e]0;${PWD}\a" }




####    OPTS
setopt extended_glob ksh_glob no_sh_glob rematch_pcre null_glob pipe_fail # err_return;
setopt long_list_jobs list_packed no_beep auto_cd interactivecomments;
setopt auto_pushd pushd_ignore_dups pushdminus;

# CASE_SENSITIVE="true";
HYPHEN_INSENSITIVE="true";
## History command configuration
HISTFILE=/root/.zsh_history;
SAVEHIST=1000;
HISTSIZE=1000; # a cushion larger than SAVEHIST, if hist_expire_dups_first set
HISTORY_IGNORE='(bl*|rm *|cat *|yt*|wc *|echo *|p *|l*|pre *|cp *|mv *|zed *|mle *|fd *|rg *|x*|qpp *|oc*|bc*|mpv*|.*|man *|tmr *|realpath *|run-help *|sf *|which *|feh *|fmt *|cd *|cl*)';
zshaddhistory () { whence ${${(z)1}[1]} >| /dev/null || return 1 }; # https://superuser.com/questions/902241/how-to-make-zsh-not-store-failed-command

setopt no_extended_history;      # record timestamp of command in HISTFILE
setopt hist_reduce_blanks;
setopt hist_ignore_dups;         # ignore duplicated commands history list
setopt hist_ignore_all_dups;     # remove old dupes
setopt hist_ignore_space;        # ignore commands that start with space
setopt hist_verify;              # show command with history expansion to user before running it
setopt share_history;            # share command history data




####    PLUGINS/AUTOLOAD
autoload -Uz zed zmv;
autoload -Uz /root/.config/zsh/autoloadmedaddy/*(.);
zle -N tetris;

# source /root/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh;

source /root/.config/zsh/plugins/completion.zsh;
autoload -Uz compaudit compinit;
autoload -Uz +X compinit && compinit;
autoload -Uz +X bashcompinit && bashcompinit;

autoload -Uz compdef;

autoload -Uz bracketed-paste-url-magic; zle -N bracketed-paste bracketed-paste-url-magic;
autoload -Uz url-quote-magic; zle -N self-insert url-quote-magic;

function d () { if [[ -n $1 ]]; then dirs "$@"; else dirs -v | head -n 10; fi };
compdef _dirs d;

FZF_BASE=/root/src/fzf;
source /root/.config/zsh/plugins/fzf/fzf.plugin.zsh;
export FZF_DEFAULT_OPTS="-i -m --reverse --ansi --bind=alt-/:toggle-preview,alt-c:clear-selection,alt-v:select-all,alt-\[:preview-up,alt-\':preview-down,\[:up,\':down";

# source /root/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh;
source /root/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh;

source /root/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh;

source /root/.config/zsh/plugins/forgit/forgit.plugin.zsh;

# source /root/.config/zsh/plugins/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh;

autoload -Uz /usr/share/zsh/functions/Calendar/*(.);
zstyle ':datetime:calendar*' reformat-date true; zstyle ':datetime:calendar*' date-format '%F %R%t';




###     KEYBINDS
#exit_zsh() { exit }
#zle -N exit_zsh
#bindkey '^D' exit_zsh




####    ALII
alias -g ...='../..';
alias -g ....='../../..';
alias -g .....='../../../..';
alias -g ......='../../../../..';
alias 1='cd -';
alias 2='cd -2';
alias 3='cd -3';
alias 4='cd -4';
alias 5='cd -5';
alias 6='cd -6';
alias 7='cd -7';
alias 8='cd -8';
alias 9='cd -9';

alias 16t='mpv --no-audio-pitch-correction';
alias bb='bye';
alias bl='subl3';
alias bll='subl3 -n --command toggle_side_bar -a';
alias catdoc='catdoc -m ${"$(stty size)"#* }';
alias clock='tty-clock -sbcS';
alias cmat='cmatrix -au2';
# alias cow='cowthink -e "^^" -f xxx -T "U"';
alias cp='cp -vR';
# alias dlwiki="wget --recursive --html-extension --page-requisites --no-parent --convert-links --no-check-certificate";
alias du='du -h';
alias fd='fd -uu -i';
alias feeds='sfeed_curses /root/.sfeed/feeds/*';
# alias ffff="echo fuck | skroll -rl -d .0025 -n 33";
# alias flite='flite -voice /root/src/voices/cmu_us_fem.flitevox --setf duration_stretch=0.46 --setf int_f0_target_mean=90 -pw';
alias fmt='fmt -w $((COLUMNS*94/100))';
alias hl='hledger-ui';
alias l='less';
alias l1='lsd -A -1 --icon never';
alias love='mpc sendmessage mpdas love';
alias lr='lsd -A --tree';
alias man='man -a';
alias mle='mle -i 1 -w 1 -y syn_generic';
alias mpi='mp3info2';
alias mpva='mpv --force-window=yes --idle --no-terminal';
alias mpvp='mpv --vo=tct --profile=sw-fast --ytdl-format="worst" --really-quiet';
alias mss='st -n "sweaper" -f "Fira Code Black:pixelsize=24" &>/dev/null & disown';
alias ncm='ncmpcpp 2>/dev/null';
alias oc='octave-cli --quiet';
alias oce='octave-cli --quiet --no-history --eval';
alias pk='pkill -KILL -x';
alias p="printf '%s\n'";
alias pre='pcre2grep -i --color';
alias rg='rg --color always --heading --line-number --smart-case --engine auto --hidden --unrestricted';
alias rdl='rdrview -B "elinks -dump -no-references -no-numbering"';
alias realpath='realpath -qe';
alias rm='rm -v';
alias rsync='rsync -vah --progress';
# alias sex='sex | cow';
# alias snow='pkill xsnow ; xsnow -snowflakes 1000 -santaspeed 15 -santa 1 -santaupdatefactor 1 -notrees -whirl 180 -yspeed 222 -xspeed 88 & disown';
# alias sx='sx ~/.xinitrc';
alias timer="source /root/.config/zsh/plugins/timer/timer.plugin.zsh; TIMER_FORMAT='[%d]'; TIMER_PRECISION=7";
# alias twitch=' mpv --profile=low-latency --video-latency-hacks=yes'
# alias tox='utox -t dark --allow-root &>/dev/null & disown';
# alias toxic='toxic -r /root/.config/tox/nameservers';
# alias unlove='mpc sendmessage mpdas unlove';
alias urlencode='perl -MURI::Escape -ep "uri_escape($ARGV[0]);"'
alias urldecode='perl -MURI::Escape -ep "uri_unescape($ARGV[0]);"'
# alias vol='amixer set Master';
alias which='which -a';
alias ytd='yt-dlp -f bestvideo+bestaudio/best --ignore-errors';
alias xb='xbacklight -set';
alias xbr='xbps-remove -R';
alias xbs='xbps-install -Su';
alias xc='xclip -r -selection clipboard';
alias xp='xclip -r -selection primary';
alias x='aunpack';
alias zcp='zmv -Cv';
alias zmv='zmv -Mv';
alias zln='zln -Lv';

alias cl='calendar';
alias cla='calendar_add';
