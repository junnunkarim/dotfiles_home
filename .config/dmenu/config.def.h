/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom */
#if ALPHA_PATCH
static int opacity = 1;                     /* -o  option; if 0, then alpha is disabled */
#endif // ALPHA_PATCH
#if FUZZYMATCH_PATCH
static int fuzzy = 1;                       /* -F  option; if 0, dmenu doesn't use fuzzy matching */
#endif // FUZZYMATCH_PATCH
#if INCREMENTAL_PATCH
static int incremental = 0;                 /* -r  option; if 1, outputs text each time a key is pressed */
#endif // INCREMENTAL_PATCH
#if INSTANT_PATCH
static int instant = 0;                     /* -n  option; if 1, selects matching item without the need to press enter */
#endif // INSTANT_PATCH
#if CENTER_PATCH
static int center = 1;                      /* -c  option; if 0, dmenu won't be centered on the screen */
static int min_width = 500;                 /* minimum width when centered */
#endif // CENTER_PATCH
#if RESTRICT_RETURN_PATCH
static int restrict_return = 0;             /* -1 option; if 1, disables shift-return and ctrl-return */
#endif // RESTRICT_RETURN_PATCH
/* -fn option overrides fonts[0]; default X11 font or font set */
#if PANGO_PATCH
static char font[] = "monospace 10";
#else
#if XRESOURCES_PATCH
static char *fonts[] =
#else
static const char *fonts[] =
#endif // XRESOURCES_PATCH
{
	"Iosevka Nerd Font Mono:style=Medium:size=13",
	//"JetBrainsMono Nerd Font Mono:style=Medium:size=12"
};
#endif // PANGO_PATCH
#if MANAGED_PATCH
static char *prompt            = NULL;      /* -p  option; prompt to the left of input field */
#else
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
#endif // MANAGED_PATCH
#if DYNAMIC_OPTIONS_PATCH
static const char *dynamic     = NULL;      /* -dy option; dynamic command to run on input change */
#endif // DYNAMIC_OPTIONS_PATCH
#if SYMBOLS_PATCH
static const char *symbol_1 = "<";
static const char *symbol_2 = ">";
#endif // SYMBOLS_PATCH

#if ALPHA_PATCH
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
	#if BORDER_PATCH
	[SchemeBorder] = { OPAQUE, OPAQUE, OPAQUE },
	#endif // BORDER_PATCH
	#if MORECOLOR_PATCH
	[SchemeMid] = { OPAQUE, baralpha, borderalpha },
	#endif // MORECOLOR_PATCH
	#if HIGHLIGHT_PATCH || FUZZYHIGHLIGHT_PATCH
	[SchemeSelHighlight] = { OPAQUE, baralpha, borderalpha },
	[SchemeNormHighlight] = { OPAQUE, baralpha, borderalpha },
	#endif // HIGHLIGHT_PATCH | FUZZYHIGHLIGHT_PATCH
	#if HIGHPRIORITY_PATCH
	[SchemeHp] = { OPAQUE, baralpha, borderalpha },
	#endif // HIGHPRIORITY_PATCH
	#if EMOJI_HIGHLIGHT_PATCH
	[SchemeHover] = { OPAQUE, baralpha, borderalpha },
	[SchemeGreen] = { OPAQUE, baralpha, borderalpha },
	[SchemeRed] = { OPAQUE, baralpha, borderalpha },
	[SchemeYellow] = { OPAQUE, baralpha, borderalpha },
	[SchemeBlue] = { OPAQUE, baralpha, borderalpha },
	[SchemePurple] = { OPAQUE, baralpha, borderalpha },
	#endif // EMOJI_HIGHLIGHT_PATCH
};
#endif // ALPHA_PATCH

static
#if !XRESOURCES_PATCH
const
#endif // XRESOURCES_PATCH
char *colors[][2] = {
	/*               fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#222222" },
	[SchemeSel]  = { "#eeeeee", "#005577" },
	[SchemeOut]  = { "#000000", "#00ffff" },
	#if BORDER_PATCH
	[SchemeBorder] = { "#000000", "#005577" },
	#endif // BORDER_PATCH
	#if MORECOLOR_PATCH
	[SchemeMid]  = { "#eeeeee", "#770000" },
	#endif // MORECOLOR_PATCH
	#if HIGHLIGHT_PATCH || FUZZYHIGHLIGHT_PATCH
	[SchemeSelHighlight]  = { "#ffc978", "#005577" },
	[SchemeNormHighlight] = { "#ffc978", "#222222" },
	#endif // HIGHLIGHT_PATCH | FUZZYHIGHLIGHT_PATCH
	#if HIGHPRIORITY_PATCH
	[SchemeHp]   = { "#bbbbbb", "#333333" },
	#endif // HIGHPRIORITY_PATCH
	#if EMOJI_HIGHLIGHT_PATCH
	[SchemeHover]  = { "#ffffff", "#353D4B" },
	[SchemeGreen]  = { "#ffffff", "#52E067" },
	[SchemeRed]    = { "#ffffff", "#e05252" },
	[SchemeYellow] = { "#ffffff", "#e0c452" },
	[SchemeBlue]   = { "#ffffff", "#5280e0" },
	[SchemePurple] = { "#ffffff", "#9952e0" },
	#endif // EMOJI_HIGHLIGHT_PATCH
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 5;
#if GRID_PATCH
/* -g option; if nonzero, dmenu uses a grid comprised of columns and lines */
static unsigned int columns    = 0;
#endif // GRID_PATCH
#if LINE_HEIGHT_PATCH
static unsigned int lineheight = 0;         /* -h option; minimum height of a menu line     */
static unsigned int min_lineheight = 8;
#endif // LINE_HEIGHT_PATCH
#if NAVHISTORY_PATCH
static unsigned int maxhist    = 15;
static int histnodup           = 1;	/* if 0, record repeated histories */
#endif // NAVHISTORY_PATCH

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
#if PIPEOUT_PATCH
static const char startpipe[] = "#";
#endif // PIPEOUT_PATCH
static const char worddelimiters[] = " ";

#if BORDER_PATCH
/* Size of the window border */
static unsigned int border_width = 2;
#endif // BORDER_PATCH

#if PREFIXCOMPLETION_PATCH
/*
 * Use prefix matching by default; can be inverted with the -x flag.
 */
static int use_prefix = 1;
#endif // PREFIXCOMPLETION_PATCH
