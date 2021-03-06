/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int minwsz    = 20;       /* Minimal heigt of a client for smfact */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Fira Code:pixelsize=14:antialias=true:autohint=true" };
static const char dmenufont[]       = "Fira Code:pixelsize=14:antialias=true:autohint=true";
static const char col_gray1[]       = "#1a1a1a";
static const char col_gray2[]       = "#4a4040";
static const char col_gray4[]       = "#f0f094";
static const char col_c1[]          = "#171313";
static const char col_c2[]          = "#9ffb00";
static const char col_c3[]          = "#fbdeef";
static const char *colors[][3]      = {
    /*               fg         bg          border   */
    [SchemeNorm] = { col_c2,    col_c1,     col_gray2 },
    [SchemeSel]  = { col_c3,    col_c1,     col_c2    },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *  WM_CLASS(STRING) = instance, class
     *  WM_NAME(STRING) = title
     */
    /* class                instance            title       tags mask     isfloating   monitor */
    { "feh",                NULL,               NULL,       0,            1,           -1 },
    { "mpv",                NULL,               NULL,       0,            1,           -1 },
    { "Firefox",            NULL,               NULL,       1 << 1,       0,           -1 },
    { "tabbed",             "tabbedsurf",       NULL,       1 << 1,       0,           -1 },
    { "surf-download",      "surf-download",    NULL,       1 << 8,       1,           -1 },
    { "Gimp",               NULL,               NULL,       1 << 2,       1,           -1 },
    { "qpdfview",           NULL,               NULL,       1 << 2,       0,           -1 },
    { "qBittorrent",        "qbittorrent",      NULL,       1 << 7,       0,           -1 },
    { "Xmessage",           "xmessage",         NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.80; /* factor of master area size [0.05..0.95] */
static const float smfact    = 0.00; /* factor of tiled clients [0.00..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[M]",      monocle },
    { "|||",      col },
    { "[]=",      tile },    /* first entry is default */
    { "><>",      NULL },    /* no layout function means floating behavior */
    {  NULL,      NULL}
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_c1, "-nf", col_c2, "-sb", col_gray1, "-sf", col_c3, NULL };
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont };
// static const char *termcmd[]  = { "st", NULL };
static const char *termcmd[] = { "tabbed", "-p", "s+1", "-c", "-r", "2", "st", "-w", "''", NULL };

static Key keys[] = {
    /* modifier                     key             function        argument */
    { MODKEY,                       XK_Escape,      spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_t,           spawn,          {.v = termcmd } },
    { MODKEY|ShiftMask,             XK_F11,         togglebar,      {0} },
    { MODKEY|ShiftMask,             XK_semicolon,   focusstack,     {.i = +1 } },
    { MODKEY|ShiftMask,             XK_p,           focusstack,     {.i = -1 } },
    { MODKEY|ShiftMask,             XK_apostrophe,  setmfact,       {.f = +0.02} },
    { MODKEY|ShiftMask,             XK_bracketleft, setmfact,       {.f = -0.02} },
    { MODKEY|ControlMask,           XK_apostrophe,  setsmfact,      {.f = -0.05} },
    { MODKEY|ControlMask,           XK_bracketleft, setsmfact,      {.f = +0.05} },
    { MODKEY|ShiftMask,             XK_bracketright,incnmaster,     {.i = +1 } },
    { MODKEY|ShiftMask,             XK_backslash,   incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_Tab,         zoom,           {0} },
    // { MODKEY|ShiftMask,             XK_Tab,         view,           {0} },
    { MODKEY|ShiftMask,             XK_k,           killclient,     {0} },
    // { MODKEY|ShiftMask,             XK_t,           setlayout,      {.v = &layouts[0]} },
    // { MODKEY|ShiftMask,             XK_f,           setlayout,      {.v = &layouts[1]} },
    // { MODKEY|ShiftMask,             XK_m,           setlayout,      {.v = &layouts[2]} },
    // { MODKEY|ShiftMask,             XK_n,           setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_space,       cyclelayout,    {.i = +1 } },
    // { MODKEY|ControlMask,           XK_comma,       cyclelayout,    {.i = -1 } },
    // { MODKEY,                       XK_space,       setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,       togglefloating, {0} },
    // { MODKEY,                       XK_0,           view,           {.ui = ~0 } },
    // { MODKEY|ShiftMask,             XK_0,           tag,            {.ui = ~0 } },
    // { MODKEY,                       XK_comma,       focusmon,       {.i = -1 } },
    // { MODKEY,                       XK_period,      focusmon,       {.i = +1 } },
    // { MODKEY|ShiftMask,             XK_comma,       tagmon,         {.i = -1 } },
    // { MODKEY|ShiftMask,             XK_period,      tagmon,         {.i = +1 } },
    { MODKEY,                       XK_comma,       shiftview,      {.i = -1 } },
    { MODKEY,                       XK_period,      shiftview,      {.i = +1 } },

    TAGKEYS(                        XK_F1,                          0)
    TAGKEYS(                        XK_F2,                          1)
    TAGKEYS(                        XK_F3,                          2)
    TAGKEYS(                        XK_F4,                          3)
    TAGKEYS(                        XK_F5,                          4)
    TAGKEYS(                        XK_F6,                          5)
    TAGKEYS(                        XK_F7,                          6)
    TAGKEYS(                        XK_F8,                          7)
    TAGKEYS(                        XK_F9,                          8)
    { MODKEY|ShiftMask,             XK_F12,         quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    // { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    // { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

