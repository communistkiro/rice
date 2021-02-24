/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom */
static int fuzzy = 1;                       /* -F  option; if 0, dmenu doesn't use fuzzy matching */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Fira Code:pixelsize=14:antialias=true:autohint=true"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*                        fg         bg       */
    [SchemeNorm]          = { "#9ffb00", "#171313" },
    [SchemeSel]           = { "#ddeedd", "#005577" },
    [SchemeNormHighlight] = { "#ffc978", "#222222" },
    [SchemeSelHighlight]  = { "#002244", "#bb1133" },
    [SchemeOut]           = { "#1a1a1a", "#fbdeef" },
};
/* -l option */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
