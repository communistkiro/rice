# rice
my config for the most part;
- navigation with `[ ; ' \` instead of cursor keys, `h j k l`, or `w a s d`;
- config files for `zsh`, `sublime text 3`, `ranger`/`lf` `ncmpcpp`, `mpd`, `less`, `conky`, other editors, other small shit;
- clones of suckless programs with relevant to me patches and configs;
- shell funcs and scripts, located in .config/zsh/{autoloadmedaddy,scripts,other}:
  - `xrp` - downloads and tags alba from bandcamp, and structures it `ARTIST/ARTIST [ALBUM (DATE)]/TRACKS`; these can then be easily be `rsync`ed to dirs by letter
  - `xrpp` - scrape embedded bandcamp from a website, specifically works with canthisevenbecalledmusic.com/; keeps track of already downloaded alba, to-be-released alba, and missing tracks in released ones;
  - `tagme` - edits metadata of audiofiles named using the format `ARTIST [ALBUM #TRACK (RELEASEDATE)] TITLE`;
  - `rdd1`/`rdd2` - bring structure to a dirs of .mp3's;
  - `pape` - choose a desktop background image along with options recursively with `dmenu`, `feh`;
  - `mpp` - insert tracks with chosen intersecting metadata using `mpc`, `dmenu`;
  - `wdr` - small weather script using `jq`, `curl/wget`, and `octave`/`asciigraph` for graphing;
  - `uhosts` - updates /etc/hosts file given specific links; mine uses last link's heading lines as the mandatory/default lines;
  ~~- `backup` -  `rsync` files and folders according to tagging glyph used in `ranger`~~ doesn't work anymore?
  - `cz` - small terminal navigation script with `dmenu`
  - `dmnt` - mount and umount disks and drives with `findmnt`, `lsblk`, and `dmenu`;
  - `pomo` - tomoto timer integrated into a `dzen2` bar over `herbstluft`'s normal top bar;
  - ~~`stream` - selct twitch category(s), language(s) and choose a stream to watch, uses `dmenu`, `sed/perl`, `mpv`~~ new api is shite;
  - `tmr` - countdown/alarm/pomodoro script, based off of Joe Standring's two; comes with a real nice foghorn i audacity'd;
  - `dwmsss` - dwm status bar script made obsolete by `slstatus` 
  - `box` - script to embox strings, optional header, and box/text/header color choice, zsh and C's printf;
  - `menu` - script to present options to choose from;
- `cfastread` - spritz reader in C, wherein I added optional wpm as first arg to facilitate input from `sfeed` script;
- `speedread` - slight modifications