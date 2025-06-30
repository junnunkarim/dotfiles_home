// appearance
static const unsigned int borderpx = 3; // border pixel of windows
/* This allows the bar border size to be explicitly set separately from borderpx.
 * If left as 0 then it will default to the borderpx value of the monitor and will
 * automatically update with setborderpx.
 */
static const unsigned int barborderpx = 0; // border pixel of bar
static const unsigned int snap = 32; // snap pixel
//
static const unsigned int gappih = 10; // horiz inner gap between windows
static const unsigned int gappiv = 10; // vert inner gap between windows
static const unsigned int gappoh = 10; // horiz outer gap between windows and screen edge
static const unsigned int gappov = 10; // vert outer gap between windows and screen edge
static const int smartgaps_fact = 1; // gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps
//
static const char autostartblocksh[] = "autostart_blocking.sh";
static const char autostartsh[] = "autostart.sh"; // using this
static const char dwmdir[] = "scripts";
static const char localshare[] = ".config/dwm";

static const int showbar = 1;   /* 0 means no bar */
static const int topbar = 1;   /* 0 means bottom bar */

// status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor)
static const int statusmon = 'A';
static const char buttonbar[] = "󰕰";

static const unsigned int systrayspacing = 10; // systray spacing
static const int showsystray = 1; // 0 means no systray
//
static const unsigned int ulinepad = 6; // horizontal padding between the underline and tag
static const unsigned int ulinestroke  = 2; // thickness/height of the underline
static const unsigned int ulinevoffset = 0; // how far above the bottom of the bar the line should appear
static const int ulineall = 0; // 1 to show underline on all tags, 0 for just the active ones

// indicators: see patch/bar_indicators.h for options
static int tagindicatortype = INDICATOR_TOP_LEFT_LARGER_SQUARE;
static int tiledindicatortype = INDICATOR_NONE;
static int floatindicatortype = INDICATOR_BOTTOM_BAR_SLIM;

static const int quit_empty_window_count = 1; // only allow dwm to quit if no (<= count) windows are open
//
static const char *fonts[] = {
  "Iosevka:style=medium:size=16",
  "Symbols Nerd Font Mono:style=medium:size=13",
};
// static const char dmenufont[] = "monospace:size=10";

// colors
// no need to change these as colors are changed through xresources
static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#bbbbbb";
static char normbgcolor[]                = "#222222";
static char normbordercolor[]            = "#444444";
static char normfloatcolor[]             = "#db8fd9";

static char selfgcolor[]                 = "#eeeeee";
static char selbgcolor[]                 = "#005577";
static char selbordercolor[]             = "#005577";
static char selfloatcolor[]              = "#005577";

static char titlenormfgcolor[]           = "#bbbbbb";
static char titlenormbgcolor[]           = "#222222";
static char titlenormbordercolor[]       = "#444444";
static char titlenormfloatcolor[]        = "#db8fd9";

static char titleselfgcolor[]            = "#eeeeee";
static char titleselbgcolor[]            = "#005577";
static char titleselbordercolor[]        = "#005577";
static char titleselfloatcolor[]         = "#005577";

static char tagsnormfgcolor[]            = "#bbbbbb";
static char tagsnormbgcolor[]            = "#222222";
static char tagsnormbordercolor[]        = "#444444";
static char tagsnormfloatcolor[]         = "#db8fd9";

static char tagsselfgcolor[]             = "#eeeeee";
static char tagsselbgcolor[]             = "#005577";
static char tagsselbordercolor[]         = "#005577";
static char tagsselfloatcolor[]          = "#005577";

static char hidnormfgcolor[]             = "#005577";
static char hidselfgcolor[]              = "#227799";
static char hidnormbgcolor[]             = "#222222";
static char hidselbgcolor[]              = "#222222";

static char urgfgcolor[]                 = "#bbbbbb";
static char urgbgcolor[]                 = "#222222";
static char urgbordercolor[]             = "#ff0000";
static char urgfloatcolor[]              = "#db8fd9";

static char scratchselfgcolor[]          = "#FFF7D4"; // doesn't change anything
static char scratchselbgcolor[]          = "#77547E"; // doesn't change anything
static char scratchselbordercolor[]      = "#894B9F"; // doesn't change anything
static char scratchselfloatcolor[]       = "#ebdbb2"; // border color when focused

static char scratchnormfgcolor[]         = "#FFF7D4"; // doesn't change anything
static char scratchnormbgcolor[]         = "#282828"; // border color when not focused
static char scratchnormbordercolor[]     = "#77547E"; // doesn't change anything
static char scratchnormfloatcolor[]      = "#77547E"; // doesn't change anything

static char *colors[][ColCount] = {
  /*                       fg                bg                border                float */
  [SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
  [SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
  [SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
  [SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
  [SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
  [SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
  [SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
  [SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
  [SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
  [SchemeScratchSel]  = { scratchselfgcolor, scratchselbgcolor, scratchselbordercolor, scratchselfloatcolor },
  [SchemeScratchNorm] = { scratchnormfgcolor, scratchnormbgcolor, scratchnormbordercolor, scratchnormfloatcolor },
};

// scratchpad initialization
static const char *scratch_term[] = {"s", "konsole", "--name", "scratch_term", NULL};
static const char *scratch_pass[] = {"w", "keepassxc", NULL};
static const char *scratch_top[] = {"t", "kitty", "--class", "scratch_top", "-e", "btop", NULL};
static const char *scratch_calc[] = {"r", "qalculate-gtk", NULL};
// static const char *scratch_docs[] = {"z", "zeal", "--name", "scratch_docs", NULL};


/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
  [DEFAULT_TAGS] = { "", "󰅨", "󰉋", "", "", "", "󰍡", "󰊖", "" },
  [ALTERNATIVE_TAGS] = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
  [ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
  /* xprop(1):
   *  WM_CLASS(STRING) = instance, class
   *  WM_NAME(STRING) = title
   *  WM_WINDOW_ROLE(STRING) = role
   *  _NET_WM_WINDOW_TYPE(ATOM) = wintype
   */

  // generic rules
  RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
  RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
  RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
  RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)

  //RULE(.class = "Alacritty", .isfloating = 0)
  RULE(.class = "konsole", .isfloating = 1, .iscentered = 1)
  RULE(.class = "Gpick", .isfloating = 1, .iscentered = 1)
  RULE(.class = "Lxappearance", .isfloating = 1, .iscentered = 1)
  RULE(.class = "Xfce-polkit", .isfloating = 1, .iscentered = 1)
  RULE(.class = "Protonvpn", .isfloating = 1, .iscentered = 1)
  RULE(.class = "KeePassXC", .isfloating = 1, .iscentered = 1)
  RULE(.class = "MEGAsync", .isfloating = 1, .iscentered = 1)

  // tag - 1
  RULE(.class = "kitty", .tags = 1 << 0, .switchtag = 1)
  RULE(.class = "term_top", .tags = 1 << 0, .switchtag = 1)
  RULE(.class = "Alacritty", .tags = 1 << 0, .switchtag = 1)
  RULE(.class = "st-256color", .tags = 1 << 0, .switchtag = 1)
  RULE(.class = "org.wezfurlong.wezterm", .tags = 1 << 0, .switchtag = 1)

  // tag - 2
  RULE(.class = "Geany", .tags = 1 << 1, .switchtag = 1)
  RULE(.class = "code-oss", .tags = 1 << 1, .switchtag = 1)
  RULE(.class = "Emacs", .tags = 1 << 1, .switchtag = 1)
  RULE(.class = "term_nvim", .tags = 1 << 1, .switchtag = 1)
  RULE(.class = "neovide", .tags = 1 << 1, .switchtag = 1)
  RULE(.class = "jetbrains-idea-ce", .tags = 1 << 1, .switchtag = 1, .iscentered = 1)
  RULE(.class = "jetbrains-pycharm", .tags = 1 << 1, .switchtag = 1, .iscentered = 1)
  RULE(.class = "jetbrains-dataspell", .tags = 1 << 1, .switchtag = 1, .iscentered = 1)

  // tag - 3
  RULE(.class = "Thunar", .tags = 1 << 2, .switchtag = 1, .iscentered = 1)
  RULE(.class = "Pcmanfm", .tags = 1 << 2, .switchtag = 1)
  RULE(.class = "term_file_manager", .tags = 1 << 2, .switchtag = 1)
  RULE(.class = "qBittorrent", .tags = 1 << 2, .switchtag = 1)

  // tag - 4
  RULE(.class = "Chromium", .tags = 1 << 3, .switchtag = 1, .iscentered = 1)
  RULE(.class = "firefox", .tags = 1 << 3, .switchtag = 1, .iscentered = 1)
  RULE(.class = "Nyxt", .tags = 1 << 3, .switchtag = 1)
  RULE(.class = "Vieb", .tags = 1 << 3, .switchtag = 1)

  // tag - 5
  RULE(.class = "Gimp", .tags = 1 << 4, .switchtag = 1, .isfloating = 1, .iscentered = 1)
  RULE(.class = "obs", .tags = 1 << 4, .switchtag = 1, .iscentered = 1)
  RULE(.class = "vlc", .tags = 1 << 4, .switchtag = 1, .iscentered = 1)
  RULE(.class = "mpv", .tags = 1 << 4, .switchtag = 1, .iscentered = 1)
  RULE(.class = "FreeTube", .tags = 1 << 4, .switchtag = 1, .iscentered = 1)

  // tag - 6
  RULE(.class = "calibre", .tags = 1 << 5, .switchtag = 1)
  RULE(.class = "Zathura", .tags = 1 << 5, .switchtag = 1)
  RULE(.class = "okular", .tags = 1 << 5, .switchtag = 1)
  RULE(.class = "Zeal", .tags = 1 << 5, .switchtag = 1)
  RULE(.class = "sioyek", .tags = 1 << 5, .switchtag = 1)
  RULE(.class = "DesktopEditors", .tags = 1 << 5, .switchtag = 1)

  // tag - 7
  RULE(.class = "KotatogramDesktop", .tags = 1 << 6, .switchtag = 1)
  RULE(.class = "TelegramDesktop", .tags = 1 << 6, .switchtag = 1)
  RULE(.class = "Session", .tags = 1 << 6, .switchtag = 1)
  
  // tag - 8
  RULE(.class = "Ryujinx", .tags = 1 << 7, .switchtag = 1, .isfloating = 1)
  RULE(.class = "yuzu", .tags = 1 << 7, .switchtag = 1, .isfloating = 1)
  RULE(.class = "retroarch", .tags = 1 << 7, .switchtag = 1, .isfloating = 0)

  // tag - 9
  RULE(.class = "GParted", .tags = 1 << 8, .switchtag = 1, .isfloating = 1, .iscentered = 1)
  RULE(.class = "Lxappearance", .tags = 1 << 8, .switchtag = 1, .isfloating = 1, .iscentered = 1)
  RULE(.class = "Virt-manager", .tags = 1 << 8, .switchtag = 1, .isfloating = 1, .iscentered = 1)
  RULE(.class = "Xfce4-power-manager-settings", .tags = 1 << 8, .switchtag = 1, .isfloating = 1, .iscentered = 1)

  // scratchpad rules
  RULE(.instance = "scratch_term", .scratchkey = 's', .isfloating = 1, .iscentered = 1)
  RULE(.instance = "keepassxc", .scratchkey = 'w', .isfloating = 1, .iscentered = 1)
  RULE(.instance = "scratch_top", .scratchkey = 't', .isfloating = 1, .iscentered = 1)
  RULE(.instance = "qalculate-gtk", .scratchkey = 'r', .isfloating = 1, .iscentered = 1)
  RULE(.instance = "scratch_docs", .scratchkey = 'z', .isfloating = 1, .iscentered = 1)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
  // monitor | bar | alignment | widthfunc | drawfunc | clickfunc | hoverfunc | name
  { -1, 0, BAR_ALIGN_LEFT, width_stbutton, draw_stbutton, click_stbutton, NULL, "statusbutton" },
  { -1, 0, BAR_ALIGN_LEFT, width_tags, draw_tags, click_tags, hover_tags, "tags" },
  { -1, 0, BAR_ALIGN_LEFT, width_ltsymbol, draw_ltsymbol, click_ltsymbol, NULL, "layout" },
  {  0, 0, BAR_ALIGN_LEFT, width_systray, draw_systray, click_systray, NULL, "systray" },
  { statusmon, 0, BAR_ALIGN_RIGHT, width_status2d, draw_status2d, click_status2d, NULL, "status2d" },
  // any component with 'BAR_ALIGN_NONE' needs to be placed at last
  // { -1, 0, BAR_ALIGN_NONE, width_wintitle, draw_wintitle, click_wintitle, NULL, "wintitle" },
	{ -1, 0, BAR_ALIGN_NONE, width_awesomebar, draw_awesomebar, click_awesomebar, NULL, "awesomebar" },
};

// layout(s)
static const float mfact = 0.55; // factor of master area size [0.05..0.95]
static const int nmaster = 1; // number of clients in master area
static const int resizehints = 0; // 1 means respect size hints in tiled resizals
static const int lockfullscreen = 1; // 1 will force focus on the fullscreen window

static const Layout layouts[] = {
  // symbol | arrange function
  // first entry is default
  { "[M]", monocle },
  { "", tile },
  { "(D)", deck },
  { "", bstack },
  { "󰾍", horizgrid },
  { "", centeredfloatingmaster },
  { "", NULL }, // no layout function means floating behavior
};

// key definitions
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask

#define TAGKEYS(KEY,TAG) \
  { MODKEY, KEY, comboview, {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask, KEY, toggleview, {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask, KEY, combotag, {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY, toggletag, {.ui = 1 << TAG} },

#define STACKKEYS(MODIFIER_KEY,ACTION) \
  { MODIFIER_KEY, XK_Tab,   ACTION##stack, {.i = INC(+1) } }, \
  { MODIFIER_KEY, XK_grave, ACTION##stack, {.i = INC(-1) } }, \
  { MODIFIER_KEY|ShiftMask, XK_Tab,     ACTION##stack, {.i = PREVSEL } },
  /*
  { MOD, XK_w,     ACTION##stack, {.i = 0 } }, \
  { MOD, XK_e,     ACTION##stack, {.i = 1 } }, \
  { MOD, XK_a,     ACTION##stack, {.i = 2 } }, \
  { MOD, XK_z,     ACTION##stack, {.i = -1 } },
  */

// helper for spawning shell commands in the pre dwm-5.0 fashion
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
// #define SHCMD(cmd) { .v = (const char*[]){ "/user/bin/fish", "-c", cmd, NULL } }

// commands to execute
static const char *terminal_cmd[]  = { "kitty", NULL };
static const char *networkmanager_cmd[]  = { "networkmanager_dmenu", NULL };
static const char *lockscreen_cmd[]  = { "betterlockscreen", "-l", NULL };

static const char *menu_switch_colorscheme_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "colorscheme_switcher",
    "-w",
    "dwm",
    "-m",
    "dmenu",
    NULL};
static const char *menu_keybindings_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "show_keybindings",
    "-m",
    "dmenu",
    "-w",
    "dwm",
    NULL};
static const char *menu_window_switcher_cmd[] = {
    ".bin/window_manager/dmenu_window_switcher.py", "-m", "dmenu", NULL};
static const char *menu_powermenu_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "powermenu",
    "-w",
    "dwm",
    "-m",
    "dmenu",
    NULL};
static const char *menu_app_launcher_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "app_launcher",
    "-m",
    "dmenu",
    "-t",
    "kitty",
    NULL};
static const char *menu_clipboard_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "clipboard",
    "-m",
    "dmenu",
    "-d",
    "x11",
    NULL};
// static const char *dmenu_calculator_cmd[]  = {
// ".config/dwm/scripts/rofi_calc", NULL };
static const char *menu_emoji_cmd[] = {".config/dwm/scripts/rofi_emoji", NULL};
static const char *menu_bookmark_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "bookmark_manager",
    "-m",
    "dmenu",
    "-b",
    "bkmr",
    "--online-status",
    "offline",
    NULL};
static const char *menu_zk_cmd[] = {
    ".bin/menu_agnostic__utilities/utilities.py",
    "zk",
    "-m",
    "dmenu",
    "-t",
    "konsole",
    NULL};

static const char *app_file_cmd[]  = { "thunar", NULL };
static const char *app_firefox_cmd[]  = { "firefox", NULL };
static const char *app_chromium_cmd[]  = { "chromium", NULL };
static const char *app_message_cmd[]  = { "telegram-desktop", NULL };
static const char *app_nvim_cmd[]  = { "neovide", NULL };

static const char *cli_file_cmd[]  = { "kitty", "--class", "term_file_manager", "-e", "yazi", NULL };
// static const char *cli_file_cmd[]  = { "kitty", "--class", "term_felix", "-e", "fx", NULL };
// static const char *cli_nvim_cmd[]  = { "kitty", "--class", "term_nvim", "-e", "nvim", NULL };

// for special keyboard keys
#include <X11/XF86keysym.h>

static const Key keys[] = {
  // NOTE: comments that start with 'desc' are parsed by
  // a script to show keybindings in dmenu or similar program

  // modifier                     key            function                argument

  //--------------------------------------------------------------//
  //---------- other programs or scripts (super + ctrl) ----------//
  //--------------------------------------------------------------//

  //desc: super + ctrl + r | turn on bluelight filter (low)
  { MODKEY|ControlMask,         XK_r,          spawn,                  SHCMD("redshift -P -O 5000") },
  //desc: super + ctrl + n | turn off bluelight filter
  { MODKEY|ControlMask,         XK_n,          spawn,                  SHCMD("redshift -x") },
  //desc: super + ctrl + v | turn off bluelight filter (high)
  { MODKEY|ControlMask,         XK_v,          spawn,                  SHCMD("redshift -P -O 3500") },
  //desc: super + ctrl + p | turn on compositor (picom)
  { MODKEY|ControlMask,         XK_p,          spawn,                  SHCMD("picom") },
  //desc: super + ctrl + u | turn off compositor (picom)
  { MODKEY|ControlMask,         XK_u,          spawn,                  SHCMD("pkill picom") },
  //desc: super + ctrl + g | open color picker (gpick)
  { MODKEY|ControlMask,         XK_g,          spawn,                  SHCMD("gpick -p") },
 

  //------------------------------------------------//
  //---------- applications (super + alt) ----------//
  //------------------------------------------------//

  //desc: super + alt + t | open file manager (thunar)
  { MODKEY|ALTKEY,              XK_t,          spawn,                  {.v = app_file_cmd } },
  //desc: super + alt + f | open cli file manager (felix)
  { MODKEY|ALTKEY,              XK_f,          spawn,                  {.v = cli_file_cmd } },
  //desc: super + alt + b | open browser (chromium)
  { MODKEY|ALTKEY,              XK_b,          spawn,                  {.v = app_chromium_cmd } },
  //desc: super + alt + e | open browser (firefox)
  { MODKEY|ALTKEY,              XK_e,          spawn,                  {.v = app_firefox_cmd } },
  //desc: super + alt + m | open message (telegram)
  { MODKEY|ALTKEY,              XK_m,          spawn,                  {.v = app_message_cmd } },
  //desc: super + alt + v | open code editor (neovim)
  // { MODKEY|ALTKEY,              XK_v,          spawn,                  {.v = cli_nvim_cmd } },
  { MODKEY|ALTKEY,              XK_v,          spawn,                  {.v = app_nvim_cmd } },

  //desc: print-screen | take fullscreen screenshot
  { 0,                            XK_Print,      spawn,                  SHCMD("flameshot full -p $HOME/pictures/ss/") },
  //desc: super + print-screen | open screenshot selection gui (flameshot)
  { MODKEY,                       XK_Print,      spawn,                  SHCMD("flameshot gui") },
  //desc: alt + print-screen | take fullscreen screenshot after 5 sec (flameshot)
  { ALTKEY,                       XK_Print,      spawn,                  SHCMD("flameshot full -d 5000 -p $HOME/pictures/ss/") },
  //desc: shift + print-screen | take fullscreen screenshot after 10 sec (flameshot)
  { ShiftMask,                    XK_Print,      spawn,                  SHCMD("flameshot full -d 10000 -p $HOME/pictures/ss/") },

  { 0,              XF86XK_MonBrightnessDown,    spawn,                  SHCMD("brightnessctl -d \"intel_backlight\" set 2%-") },
  //desc: super + f1 | decrease brightness
  { MODKEY,                       XK_F1,         spawn,                  SHCMD("brightnessctl -d \"intel_backlight\" set 2%-") },
  { 0,              XF86XK_MonBrightnessUp,      spawn,                  SHCMD("brightnessctl -d \"intel_backlight\" set +2%") },
  //desc: super + f2 | increase brightness
  { MODKEY,                       XK_F2,         spawn,                  SHCMD("brightnessctl -d \"intel_backlight\" set +2%") },

  { 0,              XF86XK_AudioLowerVolume,     spawn,                  SHCMD("pulsemixer --change-volume -5 --max-volume 100") },
  { 0,              XF86XK_AudioRaiseVolume,     spawn,                  SHCMD("pulsemixer --change-volume +5 --max-volume 100") },
  { 0,              XF86XK_AudioMute,            spawn,                  SHCMD("pulsemixer --toggle-mute") },
  //desc: super + f5 | decrease volume (system)
  { MODKEY,                       XK_F5,         spawn,                  SHCMD("pulsemixer --change-volume -5 --max-volume 100") },
  //desc: super + f6 | increase volume (system)
  { MODKEY,                       XK_F6,         spawn,                  SHCMD("pulsemixer --change-volume +5 --max-volume 100") },
  //desc: super + f7 | mute volume (system)
  { MODKEY,                       XK_F7,         spawn,                  SHCMD("pulsemixer --toggle-mute") },

  //desc: super + f9 | turn on network
  { MODKEY,                       XK_F9,         spawn,                  SHCMD("nmcli radio all on && notify-send \"Turned on wifi\"") },
  //desc: super + f10 |turn off network
  { MODKEY,                       XK_F10,        spawn,                  SHCMD("nmcli radio all off && notify-send \"Turned off wifi\"") },


  //--------------------------------------------------------------//
  //---------- System shortcuts (super / super + shift) ----------//
  //--------------------------------------------------------------//

  //desc: super + enter | open terminal
  { MODKEY,                       XK_Return,     spawn,                  {.v = terminal_cmd } },
  //desc: super + l | lock screen
  { MODKEY,                       XK_l,          spawn,                  {.v = lockscreen_cmd } },
  //desc: super + n | open network-manager (menu)
  { MODKEY,                       XK_n,          spawn,                  {.v = networkmanager_cmd } },

  //desc: super + t | open colorscheme menu (menu)
  { MODKEY,                       XK_t,          spawn,                  {.v = menu_switch_colorscheme_cmd } },
  //desc: super + k | show all keybindings (menu)
  { MODKEY,                       XK_k,          spawn,                  {.v = menu_keybindings_cmd } },
  //desc: super + w | open window switcher (menu)
  { MODKEY,                       XK_w,          spawn,                  {.v = menu_window_switcher_cmd } },
  //desc: super + x | open powermenu (menu)
  { MODKEY,                       XK_x,          spawn,                  {.v = menu_powermenu_cmd } },
  //desc: super + d | open application launcher (menu)
  // { MODKEY,                       XK_d,          spawn,                  {.v = menu_launcher_cmd } },
  { MODKEY,                       XK_d,          spawn,                  {.v = menu_app_launcher_cmd } },
  //desc: super + r | open calculator (menu)
  { MODKEY,                       XK_r,          togglescratch,          {.v = scratch_calc } },
  //desc: super + h | open clipboard (menu)
  { MODKEY,                       XK_h,          spawn,                  {.v = menu_clipboard_cmd } },
  //desc: super + e | show all emoji (menu)
  { MODKEY,                       XK_e,          spawn,                  {.v = menu_emoji_cmd } },
  //desc: super + shift + m | open bookmark manager (menu)
  { MODKEY|ShiftMask,             XK_b,          spawn,                  {.v = menu_bookmark_cmd } },
  //desc: super + z | open notes manager (menu) (zk)
  { MODKEY|ShiftMask,             XK_z,          spawn,                  {.v = menu_zk_cmd } },

  //desc: super + b | toggle bar on/off
  { MODKEY,                       XK_b,          togglebar,              {0} },
  // desc: super + shift + b | toggle bar position to top/bottom
  // { MODKEY|ShiftMask,             XK_b,          toggletopbar,           {0} },
  // { MODKEY,                       XK_Return,     zoom,                   {0} },

  // { MODKEY,                       XK_i,          incnmaster,             {.i = +1 } },
  // { MODKEY,                       XK_d,          incnmaster,             {.i = -1 } },

  //desc: super + left | increase/decrease window width
  { MODKEY,                       XK_Left,       setmfact,               {.f = -0.05} },
  //desc: super + right | increase/decrease window width
  { MODKEY,                       XK_Right,      setmfact,               {.f = +0.05} },

  //desc: super + 0 | toggle gaps on/off
  { MODKEY,                       XK_0,          togglegaps,             {0} },
  // { MODKEY|Mod4Mask,              XK_u,          incrgaps,               {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_u,          incrgaps,               {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_i,          incrigaps,              {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_i,          incrigaps,              {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_o,          incrogaps,              {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_o,          incrogaps,              {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_6,          incrihgaps,             {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_6,          incrihgaps,             {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_7,          incrivgaps,             {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_7,          incrivgaps,             {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_8,          incrohgaps,             {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_8,          incrohgaps,             {.i = -1 } },
  // { MODKEY|Mod4Mask,              XK_9,          incrovgaps,             {.i = +1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_9,          incrovgaps,             {.i = -1 } },
  // { MODKEY|Mod4Mask|ShiftMask,    XK_0,          defaultgaps,            {0} },

  // sets ALTKEY as modifier instead of MODKEY in Stacker function
  // allows cycling through focus using ALTKEY
  //desc: alt + tab | cycle focus through windows on current tag clockwise
  //desc: alt + backtick | cycle focus through windows on current tag anti-clockwise
  STACKKEYS(ALTKEY, focus)
  // allows moving through clients using ALTKEY + shift
  //desc: alt + shift + tab | move focused window on current tag clockwise
  //desc: alt + shift + backtick | move focused window on current tag anti-clockwise
  STACKKEYS(ALTKEY|ShiftMask, push)

  //desc: super + tab | cycle through active tags clockwise
  { MODKEY,                       XK_Tab,        shiftviewclients,       { .i = +1 } },
  //desc: super + period (.) | cycle through active tags clockwise
  { MODKEY,                       XK_period,     shiftviewclients,       { .i = +1 } },
  //desc: super + backtick | cycle through active tags anti-clockwise
  { MODKEY,                       XK_grave,      shiftviewclients,       { .i = -1 } },
  //desc: super + comma (,) | cycle through active tags anti-clockwise
  { MODKEY,                       XK_comma,      shiftviewclients,       { .i = -1 } },

  //desc: super + i | minimize focused window
  { MODKEY,                       XK_i,          showhideclient,         {0} },

  //desc: super + c | close focused window
  { MODKEY,                       XK_c,          killclient,             {0} },
  //desc: super + shift + q | quit dwm
  { MODKEY|ShiftMask,             XK_q,          quit,                   {0} },
  //desc: super + shift + r | restart dwm
  { MODKEY|ShiftMask,             XK_r,          quit,                   {1} },
  //desc: super + shift + f5 | reload dwm colors
  { MODKEY|ShiftMask,             XK_F5,         xrdb,                   {.v = NULL } },

  //desc: super + shift + f | toggle floating layout of focused window
  { MODKEY|ShiftMask,             XK_f,          togglefloating,         {0} },

  //desc: super + shift + enter | toggle terminal scratchpad
  { MODKEY|ShiftMask,             XK_Return,     togglescratch,          {.v = scratch_term } },
  //desc: super + shift + backspace | toggle password manager scratchpad
  { MODKEY|ShiftMask,             XK_BackSpace,  togglescratch,          {.v = scratch_pass } },
  //desc: super + shift + h | toggle task-manager scratchpad
  { MODKEY|ShiftMask,             XK_h,          togglescratch,          {.v = scratch_top } },
  // desc: super + shift + z | toggle documentation borwser scratchpad (zeal)
  // { MODKEY|ShiftMask,             XK_z,          togglescratch,          {.v = scratch_docs } },

  // { MODKEY|ControlMask,           XK_grave,      setscratch,             {.v = scratchpadcmd } },
  // { MODKEY|ShiftMask,             XK_grave,      removescratch,          {.v = scratchpadcmd } },

  //desc: super + f | toggle fullscreen of focused window
  { MODKEY,                       XK_f,          togglefullscreen,       {0} },

  // { MODKEY,                       XK_Tab,        view,                   {0} },

  // { MODKEY,                       XK_t,          setlayout,              {.v = &layouts[0]} },
  // { MODKEY,                       XK_f,          setlayout,              {.v = &layouts[1]} },
  // { MODKEY,                       XK_m,          setlayout,              {.v = &layouts[2]} },
  // { MODKEY,                       XK_space,      setlayout,              {0} },

  // { MODKEY,                       XK_0,          view,                   {.ui = ~0 } },
  // { MODKEY|ShiftMask,             XK_0,          tag,                    {.ui = ~0 } },

  // multi-monitor related
  // { MODKEY,                       XK_comma,      focusmon,               {.i = -1 } },
  // { MODKEY,                       XK_period,     focusmon,               {.i = +1 } },
  // { MODKEY|ShiftMask,             XK_comma,      tagmon,                 {.i = -1 } },
  // { MODKEY|ShiftMask,             XK_period,     tagmon,                 {.i = +1 } },

  //desc: super + ctrl + space | cycle through layouts clockwise
  { MODKEY|ControlMask,           XK_space,      cyclelayout,            {.i = +1 } },
  //desc: super + shift + ctrl + space | cycle through layouts anti-clockwise
  { MODKEY|ShiftMask|ControlMask, XK_space,      cyclelayout,            {.i = -1 } },

  //desc: super + [1-9] | move to corresponding tag
  //desc: super + shift + [1-9] | move focused window to corresponding tag
  TAGKEYS(                        XK_1,                                  0)
  TAGKEYS(                        XK_2,                                  1)
  TAGKEYS(                        XK_3,                                  2)
  TAGKEYS(                        XK_4,                                  3)
  TAGKEYS(                        XK_5,                                  4)
  TAGKEYS(                        XK_6,                                  5)
  TAGKEYS(                        XK_7,                                  6)
  TAGKEYS(                        XK_8,                                  7)
  TAGKEYS(                        XK_9,                                  8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask           button          function        argument */
  { ClkButton,            0,                   Button1,        spawn,          {.v = menu_app_launcher_cmd } },

  { ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },

  { ClkWinTitle,          0,                   Button1,        showhideclient, {0} },
  { ClkWinTitle,          0,                   Button3,        togglewin,      {0} },
  { ClkWinTitle,          0,                   Button2,        zoom,           {0} },

  { ClkStatusText,        0,                   Button1,        spawn,          {.v = menu_powermenu_cmd } },
  /* placemouse options, choose which feels more natural:
   *    0 - tiled position is relative to mouse cursor
   *    1 - tiled postiion is relative to window center
   *    2 - mouse pointer warps to window center
   *
   * The moveorplace uses movemouse or placemouse depending on the floating state
   * of the selected client. Set up individual keybindings for the two if you want
   * to control these separately (i.e. to retain the feature to move a tiled window
   * into a floating position).
   */
  { ClkClientWin,         MODKEY,              Button1,        moveorplace,    {.i = 1} },
  { ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,                   Button1,        view,           {0} },
  { ClkTagBar,            0,                   Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

/* signal definitions */
/* signum must be greater than 0 */
/* trigger signals using `xsetroot -name "fsignal:<signum>"` */
static Signal signals[] = {
  /* signum       function        argument  */
  { 1,            setlayout,      {.v = 0} },
  { 2,            xrdb,           {.v = 0} },
};
