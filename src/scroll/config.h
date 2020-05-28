/*
 * Define ESC sequences to use for scroll events.
 * Use "cat -v" to figure out favorite key combination.
 *
 * lines is the number of lines scrolled up or down.
 * If lines is negative, its the fraction of the terminal size.
 */

struct rule rules[] = {
	/* sequence     event         lines */
	{"\033[5;2~",	SCROLL_UP,   -1},	/* [Shift] + [PageUP] */
	{"\033[6;2~",	SCROLL_DOWN, -1},	/* [Shift] + [PageDown] */
	{"\031",	    SCROLL_UP,    3},	/* mouse wheel up */
	{"\005",	    SCROLL_DOWN,  3}	/* mouse wheel Down */
};