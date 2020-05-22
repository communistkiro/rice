# rice
my config for the most part;
- most navigation with `[ ; ' \` instead of cursor keys or `w a s d`; this includes `tabbed`, `dwm`, `herbstluft`; 
- config files `zsh`, `subl3`, `ranger`, `ncmpcpp`, `mpd`, `conky`, other editors, other small shit;
- clones of suckless programs with relevant to me patches and configs;
- shell funcs and scripts, located in .config/zsh/{autoloadmedaddy,scripts,other}:
  - `xrp` - downloads and tags alba from bandcamp, and structures it `ARTIST/ARTIST [ALBUM (DATE)]/TRACKS`; these can then be easily be `rsync`ed to dirs by letter
  - `xrpp` - scrape embedded bandcamp from a website, specifically works with canthisevenbecalledmusic.com/; keeps track of already downloaded alba, to-be-released alba, and missing tracks in released ones; 
  - `pape` - choose a desktop background image along with options recursively with dmenu, feh
  - `mpp` - insert tracks with chosen intersecting metadata
  - `wdr` - small weather app using octave, js, curl/wget
  - `uhosts` - updates /etc/hosts file given specific links; mine uses last link's heading lines as the mandatory/default lines;
  - `backup` -  `rsync` files and folders according to tagging glyph used in `ranger`
  - `cz` - small terminal navigation program with dmenu
  - `dmnt` - mount and umount disks and drives with `findmnt` and `lsblk`;
  - `pomo` - tomoto timer integrated into a `dzen2` bar over the normal bar; inteded use with `herbstluft`
  - ~~`stream` - selct twitch category(s), language(s) and choose a stream to watch, uses `dmenu`, `sed/perl`, `mpv`~~ new api is shite;
  - `tmr` - countdown/alarm, based off of Joe Standring's two scripts; comes with a real nice foghorn i audacity'd;