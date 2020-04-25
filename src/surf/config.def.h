/* modifier 0 means no modifier */
static int surfuseragent    = 1;  /* Append Surf version to default WebKit user agent */
static char *fulluseragent  = ""; /* Or override the whole user agent string */
static char *styledir       = "~/.surf/styles/";
static char *scriptdir      = "~/.surf/script/";
static char *certdir        = "~/.surf/certificates/";
static char *cachedir       = "~/.surf/cache/";
static char *cookiefile     = "~/.surf/cookies.txt";
static char *scriptfiles[]  = {
	"~/.surf/user.js",
};

/* Webkit default features */
/* Highest priority value will be used.
 * Default parameters are priority 0
 * Per-uri parameters are priority 1
 * Command parameters are priority 2
 */
static Parameter defconfig[ParameterLast] = {
	/* parameter                    Arg value       priority */
	[AcceleratedCanvas]   =       { { .i = 1 },     },
	[AccessMicrophone]    =       { { .i = 0 },     },
	[AccessWebcam]        =       { { .i = 0 },     },
	[Certificate]         =       { { .i = 0 },     },
	[CaretBrowsing]       =       { { .i = 0 },     },
	[CookiePolicies]      =       { { .v = "@aA" }, },
	[DefaultCharset]      =       { { .v = "UTF-8" }, },
	[DiskCache]           =       { { .i = 1 },     },
	[DNSPrefetch]         =       { { .i = 0 },     },
	[FileURLsCrossAccess] =       { { .i = 0 },     },
	[FontSize]            =       { { .i = 16 },    },
	[FrameFlattening]     =       { { .i = 0 },     },
	[Geolocation]         =       { { .i = 0 },     },
	[HideBackground]      =       { { .i = 0 },     },
	[Inspector]           =       { { .i = 0 },     },
	[Java]                =       { { .i = 1 },     },
	[JavaScript]          =       { { .i = 1 },     },
	[KioskMode]           =       { { .i = 0 },     },
	[LoadImages]          =       { { .i = 1 },     },
	[MediaManualPlay]     =       { { .i = 1 },     },
	[Plugins]             =       { { .i = 1 },     },
	[PreferredLanguages]  =       { { .v = (char *[]){ NULL } }, },
	[RunInFullscreen]     =       { { .i = 0 },     },
	[ScrollBars]          =       { { .i = 1 },     },
	[ShowIndicators]      =       { { .i = 1 },     },
	[SiteQuirks]          =       { { .i = 1 },     },
	[SmoothScrolling]     =       { { .i = 0 },     },
	[SpellChecking]       =       { { .i = 0 },     },
	[SpellLanguages]      =       { { .v = ((char *[]){ "en_US", NULL }) }, },
	[StrictTLS]           =       { { .i = 1 },     },
	[Style]               =       { { .i = 1 },     },
    [UserScript]          =       { { .i = 1 },     },
	[WebGL]               =       { { .i = 0 },     },
	[ZoomLevel]           =       { { .f = 1.0 },   },
};

static UriParameters uriparams[] = {
	{ "(://|\\.)suckless\\.org(/|$)", {
	  [JavaScript] = { { .i = 0 }, 1 },
	  [Plugins]    = { { .i = 0 }, 1 },
	}, },
};

/* default window size: width, height */
static int winsize[] = { 800, 600 };

static WebKitFindOptions findopts = WEBKIT_FIND_OPTIONS_CASE_INSENSITIVE |
                                    WEBKIT_FIND_OPTIONS_WRAP_AROUND;

#define PROMPT_GO   "Go:"
#define PROMPT_FIND "Find:"

/* SETPROP(readprop, setprop, prompt)*/
#define SETPROP(r, s, p) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "prop=\"$(printf '%b' \"$(xprop -id $1 $2 " \
             "| sed \"s/^$2(STRING) = //;s/^\\\"\\(.*\\)\\\"$/\\1/\")\" " \
             "| dmenu -p \"$4\" -w $1)\" && xprop -id $1 -f $3 8s -set $3 \"$prop\"", \
             "surf-setprop", winid, r, s, p, NULL \
        } \
}

/* DOWNLOAD(URI, referer) */
#define DOWNLOAD(u, r) { \
        .v = (const char *[]){ "st", "-e", "/bin/sh", "-c",\
             "curl -g -L -J -O -A \"$1\" -b \"$2\" -c \"$2\"" \
             " -e \"$3\" \"$4\"; read", \
             "surf-download", useragent, cookiefile, r, u, NULL \
        } \
}

/* PLUMB(URI) */
/* This called when some URI which does not begin with "about:",
 * "http://" or "https://" should be opened.
 */
#define PLUMB(u) {\
        .v = (const char *[]){ "/bin/sh", "-c", \
             "xdg-open \"$0\"", u, NULL \
        } \
}

/* VIDEOPLAY(URI) */
#define VIDEOPLAY(u) {\
        .v = (const char *[]){ "/bin/sh", "-c", \
             "mpv --really-quiet \"$0\"", u, NULL \
        } \
}

#define HOMEPAGE "file:///root/.config/startpage/ss1.htm"

#define QSEARCH { \
    .v = (char *[]){"/bin/sh", "-c", \
    "/root/.config/zsh/scripts/surf_qsearch $0 $1", \
    winid, NULL } \
}

#define SR_SEARCH {\
    .v = (char *[]){ "/bin/sh", "-c", \
	"xprop -id $0 -f _SURF_GO 8s -set _SURF_GO $(surfraw -p $(surfraw -elvi | tail -n +2 | cut -s -f1 | dmenu -i))", \
    winid, NULL }\
}

/* styles */
/*
 * The iteration will stop at the first match, beginning at the beginning of
 * the list.
 */
static SiteSpecific styles[] = {
	/* regexp               file in $styledir */
    { "://boards\\.4chan.*", "non.css" },
	{ ".*",                 "default.css" },
};

 
/* scripts */
static SiteSpecific scripts[] = {
   /* regexp               file in $scriptdir */
   // { ".*",                 "default.js" },
    { "://boards\\.4chan.*", "4chan-X.user.js" },
};

/* certificates */
/*
 * Provide custom certificate for urls
 */
static SiteSpecific certs[] = {
	/* regexp               file in $certdir */
	{ "://suckless\\.org/", "suckless.org.crt" },
};

#define MODKEY GDK_MOD1_MASK

/* HOTKEYS */
/*
 * IF YOU USE ANYTHING ELSE BUT MODKEY AND GDK_SHIFT_MASK, DON'T FORGET TO
 * EDIT THE CLEANMASK() MACRO.
 */
static Key keys[] = {
	/* modifier                keyval                      function            arg */
	{ MODKEY,                  GDK_KEY_g,                  spawn,              SETPROP("_SURF_URI", "_SURF_GO", PROMPT_GO) },
	{ MODKEY,                  GDK_KEY_f,                  spawn,              SETPROP("_SURF_FIND", "_SURF_FIND", PROMPT_FIND) },
    { MODKEY,                  GDK_KEY_q,                  spawn,              QSEARCH },
    { MODKEY,                  GDK_KEY_w,      			   spawn,              SR_SEARCH },

	{ 0,                       GDK_KEY_Escape,             stop,               { 0 } },
	// { MODKEY,                  GDK_KEY_c,                    stop,               { 0 } },

	{ GDK_CONTROL_MASK,        GDK_KEY_r,                  reload,             { .i = 0 } },
	{ GDK_CONTROL_MASK|MODKEY, GDK_KEY_r,                  reload,             { .i = 1 } },

    // navigate history
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_backslash,          navigate,           { .i = +1 } },
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_semicolon,          navigate,           { .i = -1 } },

	 // vertical and horizontal scrolling, in viewport percentage 
    { MODKEY,                  GDK_KEY_apostrophe,         scrollv,            { .i = +10 } },
    { MODKEY,                  GDK_KEY_bracketleft,        scrollv,            { .i = -10 } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_semicolon,          scrollh,            { .i = +10 } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_backslash,          scrollh,            { .i = -10 } },


	{ MODKEY,                  GDK_KEY_minus,              zoom,               { .i = -1 } },
	{ MODKEY,                  GDK_KEY_equal,              zoom,               { .i = +1 } },

	{ GDK_CONTROL_MASK,        GDK_KEY_c,                  clipboard,          { .i = 0 } },
	{ GDK_CONTROL_MASK,        GDK_KEY_v,                  clipboard,          { .i = 1 } },

	{ MODKEY,                  GDK_KEY_n,                  find,               { .i = +1 } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_n,                  find,               { .i = -1 } },

	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_p,                  print,              { 0 } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_t,                  showcert,           { 0 } },

	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_a,                  togglecookiepolicy, { 0 } },
	{ 0,                       GDK_KEY_F11,                togglefullscreen,   { 0 } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_o,                  toggleinspector,    { 0 } },

	{ GDK_SHIFT_MASK,          GDK_KEY_F9,                 toggle,             { .i = CaretBrowsing } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_f,                  toggle,             { .i = FrameFlattening } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_s,                  toggle,             { .i = JavaScript } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_i,                  toggle,             { .i = LoadImages } },
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_g,                  toggle,             { .i = Geolocation } },
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_v,                  toggle,             { .i = Plugins } },
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_b,                  toggle,             { .i = ScrollBars } },
	{ MODKEY|GDK_CONTROL_MASK, GDK_KEY_t,                  toggle,             { .i = StrictTLS } },
	{ MODKEY|GDK_SHIFT_MASK,   GDK_KEY_m,                  toggle,             { .i = Style } },
    { MODKEY|GDK_SHIFT_MASK,   GDK_KEY_w,                  playexternal,       { 0 } },
};

/* VIDEOPLAY(URI) */
#define VIDEOPLAY(u) {\
    .v = (const char *[]){ "/bin/sh", "-c", \
         "mpv --really-quiet \"$0\"", u, NULL \
    } \
}

/* button definitions */
/* target can be OnDoc, OnLink, OnImg, OnMedia, OnEdit, OnBar, OnSel, OnAny */
static Button buttons[] = {
	/* target       event mask      button  function           argument        stop event */
	{ OnLink,       0,              2,      clicknewwindow,    { .i = 0  },    1 },
	{ OnLink,       MODKEY,         2,      clicknewwindow,    { .i = 1  },    1 },
	{ OnLink,       MODKEY,         1,      clicknewwindow,    { .i = 1  },    1 },
	{ OnAny,        0,              8,      clicknavigate,     { .i = -1 },    1 },
	{ OnAny,        0,              9,      clicknavigate,     { .i = +1 },    1 },
	{ OnMedia,      MODKEY,         1,      clickexternplayer, { 0       },    1 },
};
