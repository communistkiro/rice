/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]        = "Fira Code Medium:pixelsize=16:antialias=true:autohint=true";

static const char* normbgcolor  = "#301E28";
static const char* normfgcolor  = "#82B3B3";
static const char* selbgcolor   = "#170E12";
static const char* selfgcolor   = "#BAFFFF";

static const char* urgbgcolor   = "#111111";
static const char* urgfgcolor   = "#cc0000";
static const char before[]      = "<";
static const char after[]       = ">";
static const char titletrim[]   = "…";
static const int  tabwidth      = 120;
static const Bool foreground    = True;
static       Bool urgentswitch  = False;

/*
 * Where to place a new tab when it is opened. When npisrelative is True,
 * then the current position is changed + newposition. If npisrelative
 * is False, then newposition is an absolute position.
 */
static int  newposition   = +1;
static Bool npisrelative  = True;

#define SETPROP(p) { \
        .v = (char *[]){ "/bin/sh", "-c", \
                "prop=\"`xwininfo -children -id $1 | grep '^     0x' |" \
                "sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' |" \
                "xargs -0 printf %b | dmenu -l 10 -w $1`\" &&" \
                "xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
                p, winid, NULL \
        } \
}

#define MODKEY Mod1Mask
static Key keys[] = {
    /* modifier             key              function     argument */
    { MODKEY,               XK_grave,        focusonce,   { 0 } },
    { MODKEY,               XK_grave,        spawn,       { 0 } },
    
    { MODKEY,               XK_semicolon,    rotate,      { .i= -1 } },
    { MODKEY,               XK_backslash,    rotate,      { .i= +1 } },
    // { ControlMask,          XK_quote,        rotate,      { .i = 0 } },/* to previously selected tab */
    
    { MODKEY|ControlMask,   XK_semicolon,    movetab,     { .i= -1 } },
    { MODKEY|ControlMask,   XK_backslash,    movetab,     { .i= +1 } },
    
    { MODKEY|ShiftMask,     XK_1,            move,        { .i= 0 } },
    { MODKEY|ShiftMask,     XK_2,            move,        { .i= 1 } },
    { MODKEY|ShiftMask,     XK_3,            move,        { .i= 2 } },
    { MODKEY|ShiftMask,     XK_4,            move,        { .i= 3 } },
    { MODKEY|ShiftMask,     XK_5,            move,        { .i= 4 } },
    { MODKEY|ShiftMask,     XK_6,            move,        { .i= 5 } },
    { MODKEY|ShiftMask,     XK_7,            move,        { .i= 6 } },
    { MODKEY|ShiftMask,     XK_8,            move,        { .i= 7 } },
    { MODKEY|ShiftMask,     XK_9,            move,        { .i= 8 } },
    { MODKEY|ShiftMask,     XK_0,            move,        { .i= 9 } },
    
    
    { MODKEY|ShiftMask,     XK_q,            killclient,  { 0 } },
    
    // { MODKEY,               XK_u,            focusurgent, { 0 } },
    // { MODKEY|ShiftMask,     XK_u,            toggle,      { .v = (void*) &urgentswitch } },
    
    { 0,                    XK_F11,          fullscreen,  { 0 } },
};
