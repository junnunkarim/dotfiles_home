/* Patches */

/* The alpha patch adds transparency for the dmenu window.
 * You need to uncomment the corresponding line in config.mk to use the -lXrender library
 * when including this patch.
 * https://github.com/bakkeby/patches/blob/master/dmenu/dmenu-alpha-5.0_20210725_523aa08.diff
 */
#define ALPHA_PATCH 0

/* This adds padding for dmenu in similar fashion to the similarly named patch for dwm. The idea
 * is to have dmenu appear on top of the bar when using said patch in dwm.
 * https://github.com/bakkeby/patches/wiki/barpadding
 */
#define BARPADDING_PATCH 0

/* This patch adds a border around the dmenu window. It is intended to be used with the center
 * or xyw patches, to make the menu stand out from similarly coloured windows.
 * http://tools.suckless.org/dmenu/patches/border/
 */
#define BORDER_PATCH 0

/* By default the caret in dmenu has a width of 2 pixels. This patch makes that configurable
 * as well as overridable via a command line option.
 * https://github.com/DarkSamus669/dmenu-patches/blob/main/dmenu-caretwidth-5.2.diff
 */
#define CARET_WIDTH_PATCH 0

/* This patch makes dmenu case-insensitive by default, replacing the
 * case-insensitive -i option with a case sensitive -s option.
 * http://tools.suckless.org/dmenu/patches/case-insensitive/
 */
#define CASEINSENSITIVE_PATCH 0

/* This patch centers dmenu in the middle of the screen.
 * https://tools.suckless.org/dmenu/patches/center/
 */
#define CENTER_PATCH 0

/* Minor patch to enable the use of Ctrl+v (XA_PRIMARY) and Ctrl+Shift+v (CLIPBOARD) to paste.
 * By default dmenu only supports Ctrl+y and Ctrl+Shift+y to paste.
 */
#define CTRL_V_TO_PASTE_PATCH 0

/* This patch adds a flag (-dy) which makes dmenu run the command given to it whenever input
 * is changed with the current input as the last argument and update the option list according
 * to the output of that command.
 * https://tools.suckless.org/dmenu/patches/dynamicoptions/
 */
#define DYNAMIC_OPTIONS_PATCH 0

/* This patch will allow for emojis on the left side with a colored background when selected.
 * To test this try running:
 *    $ echo -e ":b here\n:p there\n:r and here" | ./dmenu -p "Search..." -W 400 -l 20 -i -h -1
 * NB: the original patch came embedded with the the xyw patch, the morecolors patch and the
 * line height patch and as such is intended to be combined with these.
 * https://tools.suckless.org/dmenu/patches/emoji-highlight/
 */
#define EMOJI_HIGHLIGHT_PATCH 0

/* This patch make it so that fuzzy matches gets highlighted and is therefore meant
 * to be used together with the fuzzymatch patch.
 * https://tools.suckless.org/dmenu/patches/fuzzyhighlight/
 */
#define FUZZYHIGHLIGHT_PATCH 0

/* This patch adds support for fuzzy-matching to dmenu, allowing users to type non-consecutive
 * portions of the string to be matched.
 * https://tools.suckless.org/dmenu/patches/fuzzymatch/
 */
#define FUZZYMATCH_PATCH 0

/* Adds fzf-like functionality for dmenu.
 * Refer to https://github.com/DAFF0D11/dafmenu/ for documentation and example use cases.
 * https://github.com/DAFF0D11/dafmenu/blob/master/patches/dmenu-fzfexpect-5.1.diff
 */
#define FZFEXPECT_PATCH 0

/* Allows dmenu's entries to be rendered in a grid by adding a new -g flag to specify
 * the number of grid columns. The -g and -l options can be used together to create a
 * G columns * L lines grid.
 * https://tools.suckless.org/dmenu/patches/grid/
 */
#define GRID_PATCH 0

/* This patch adds the ability to move left and right through a grid.
 * This patch depends on the grid patch.
 * https://tools.suckless.org/dmenu/patches/gridnav/
 */
#define GRIDNAV_PATCH 0

/* This patch highlights the individual characters of matched text for each dmenu list entry.
 * The fuzzy highlight patch takes precedence over this patch.
 * https://tools.suckless.org/dmenu/patches/highlight/
 */
#define HIGHLIGHT_PATCH 0

/* This will automatically sort the search result so that high priority items are shown first.
 * https://tools.suckless.org/dmenu/patches/highpriority/
 */
#define HIGHPRIORITY_PATCH 0

/* This patch causes dmenu to print out the current text each time a key is pressed.
 * https://tools.suckless.org/dmenu/patches/incremental/
 */
#define INCREMENTAL_PATCH 0

/* This patch adds an option to provide preselected text.
 * https://tools.suckless.org/dmenu/patches/initialtext/
 */
#define INITIALTEXT_PATCH 0

/* This patch adds a flag which will cause dmenu to select an item immediately if there
 * is only one matching option left.
 * https://tools.suckless.org/dmenu/patches/instant/
 */
#define INSTANT_PATCH 0

/* This patch adds a '-h' option which sets the minimum height of a dmenu line. This helps
 * integrate dmenu with other UI elements that require a particular vertical size.
 * http://tools.suckless.org/dmenu/patches/line-height/
 */
#define LINE_HEIGHT_PATCH 0

/* This patch adds a -wm flag which sets override_redirect to false; thus letting your window
 * manager manage the dmenu window.
 *
 * This may be helpful in contexts where you don't want to exclusively bind dmenu or want to
 * treat dmenu more as a "window" rather than as an overlay.
 * https://tools.suckless.org/dmenu/patches/managed/
 */
#define MANAGED_PATCH 0

/* This patch adds an additional color scheme for highlighting entries adjacent to the current
 * selection.
 * https://tools.suckless.org/dmenu/patches/morecolor/
 */
#define MORECOLOR_PATCH 0

/* This patch adds basic mouse support for dmenu.
 * https://tools.suckless.org/dmenu/patches/mouse-support/
 */
#define MOUSE_SUPPORT_PATCH 0

/* Without this patch when you press Ctrl+Enter dmenu just outputs current item and it is not
 * possible to undo that.
 * With this patch dmenu will output all selected items only on exit. It is also possible to
 * deselect any selected item.
 * Also refer to the dmenu_run replacement on the below URL that supports multiple selections.
 *
 * This patch is not compatible with, and takes precedence over, the json, printinputtext,
 * pipeout and non-blocking stdin patches.
 *
 * https://tools.suckless.org/dmenu/patches/multi-selection/
 */
#define MULTI_SELECTION_PATCH 0

/* This patch provides dmenu the ability for history navigation similar to that of bash.
 *
 * If you take this patch then it is recommended that you also uncomment the line in the
 * dmenu_run script which replaces the exec command.
 *
 * https://tools.suckless.org/dmenu/patches/navhistory/
 */
#define NAVHISTORY_PATCH 0

/* This patch adds back in the workaround for a BadLength error in the Xft library when color
 * glyphs are used. This is for systems that do not have an updated version of the Xft library
 * (or generally prefer monochrome fonts).
 */
#define NO_COLOR_EMOJI_PATCH 0

/* Adds the -S option to disable sorting menu items after matching. Useful, for example, when menu
 * items are sorted by their frequency of use (using an external cache) and the most frequently
 * selected items should always appear first regardless of how they were exact, prefix, or
 * substring matches.
 * https://tools.suckless.org/dmenu/patches/no-sort/
 */
#define NO_SORT_PATCH 0

/* This is a patch to have dmenu read stdin in a non blocking way, making it wait for input both
 * from stdin and from X. This means that you can continue feeding dmenu while you type.
 * This patch is meant to be used along with the incremental patch, so that you can use stdout
 * to feed stdin.
 *
 * This patch is not compatible with the json and multi-selection patches, both of which takes
 * precedence over this patch.
 *
 * https://tools.suckless.org/dmenu/patches/non_blocking_stdin/
 */
#define NON_BLOCKING_STDIN_PATCH 0

/* Adds text which displays the number of matched and total items in the top right corner of dmenu.
 * https://tools.suckless.org/dmenu/patches/numbers/
 */
#define NUMBERS_PATCH 0

/* This patch adds simple markup for dmenu using pango markup.
 * This depends on the pango library v1.44 or greater.
 * You need to uncomment the corresponding lines in config.mk to use the pango libraries
 * when including this patch.
 *
 * Note that the pango patch is incompatible with the scroll patch and will result in
 * compilation errors if both are enabled.
 *
 * Note that the pango patch does not protect against the BadLength error from Xft
 * when color glyphs are used, which means that dmenu will crash if color emoji is used.
 *
 * If you need color emoji then you may want to install this patched library from the AUR:
 * https://aur.archlinux.org/packages/libxft-bgra/
 *
 * A long term fix for the libXft library is pending approval of this pull request:
 * https://gitlab.freedesktop.org/xorg/lib/libxft/-/merge_requests/1
 *
 * Also see:
 * https://developer.gnome.org/pygtk/stable/pango-markup-language.html
 * https://github.com/StillANixRookie/dmenu-pango
 */
#define PANGO_PATCH 0

/* With this patch dmenu will not directly display the keyboard input, but instead replace
 * it with dots. All data from stdin will be ignored.
 * https://tools.suckless.org/dmenu/patches/password/
 */
#define PASSWORD_PATCH 0

/* This patch allows the selected text to be piped back out with dmenu. This can be useful if you
 * want to display the output of a command on the screen.
 * Only text starting with the character '#' is piped out by default.
 *
 * This patch is not compatible with the json and multi-select patches, both of which takes
 * precedence over this one.
 *
 * https://tools.suckless.org/dmenu/patches/pipeout/
 */
#define PIPEOUT_PATCH 0

/* Lifted from the listfullwidth patch this simple change just avoids colors for the prompt (with
 * the -p option or in config.h) by making it use the same style as the rest of the input field.
 * The rest of the listfullwidth patch is covered by the vertfull patch.
 * https://tools.suckless.org/dmenu/patches/listfullwidth/
 */
#define PLAIN_PROMPT_PATCH 0

/* This patch changes the behaviour of matched items and the Tab key to allow tab completion.
 * https://tools.suckless.org/dmenu/patches/prefix-completion/
 */
#define PREFIXCOMPLETION_PATCH 0

/* This patch adds an option -ps to specify an item by providing the index that should be
 * pre-selected.
 * https://tools.suckless.org/dmenu/patches/preselect/
 */
#define PRESELECT_PATCH 0

/* This patch allows dmenu to print out the 0-based index of matched text instead of the matched
 * text itself. This can be useful in cases where you would like to select entries from one array
 * of text but index into another, or when you are selecting from an ordered list of non-unique
 * items.
 * https://tools.suckless.org/dmenu/patches/printindex/
 */
#define PRINTINDEX_PATCH 0

/* This patch adds a flag (-t) which makes Return key to ignore selection and print the input
 * text to stdout. The flag basically swaps the functions of Return and Shift+Return hotkeys.
 *
 * This patch is not compatible with the multi-select and json patches, both of which takes
 * precedence over this one.
 *
 * https://tools.suckless.org/dmenu/patches/printinputtext/
 */
#define PRINTINPUTTEXT_PATCH 0

/* This patch adds a new flag to dmenu with which text input will be rejected if it would
 * result in no matching item.
 * https://tools.suckless.org/dmenu/patches/reject-no-match/
 */
#define REJECTNOMATCH_PATCH 0

/* The input width used to be relative to the input options prior to commit e1e1de7:
 * https://git.suckless.org/dmenu/commit/e1e1de7b3b8399cba90ddca9613f837b2dbef7b9.html
 *
 * This had a performance hit when using large data sets and was removed in favour of having the
 * input width take up 1/3rd of the available space.
 *
 * This option adds that feature back in with some performance optimisations at the cost of
 * accuracy and correctness.
 */
#define RELATIVE_INPUT_WIDTH_PATCH 0

/* This patch adds a '-1' option which disables Shift-Return and Ctrl-Return.
 * This guarantees that dmenu will only output one item, and that item was read from stdin.
 * The original patch used '-r'. This was changed to '-1' to avoid conflict with the incremental
 * patch.
 * https://tools.suckless.org/dmenu/patches/restrict-return/
 */
#define RESTRICT_RETURN_PATCH 0

/* This patch adds support for text scrolling and no longer appends '...' for long input as
 * it can handle long text.
 * https://tools.suckless.org/dmenu/patches/scroll/
 */
#define SCROLL_PATCH 0

/* This patch adds -d and -D flags which separates the input into two halves; one half to be
 * displayed in dmenu and the other to be printed to stdout. This patch takes precedence over
 * the TSV patch.
 * https://tools.suckless.org/dmenu/patches/separator/
 */
#define SEPARATOR_PATCH 0

/* This patch allows the symbols, which are printed in dmenu to indicate that either the input
 * is too long or there are too many options to be shown in dmenu in one line, to be defined.
 * https://tools.suckless.org/dmenu/patches/symbols/
 */
#define SYMBOLS_PATCH 0

/* With this patch dmenu will split input lines at first tab character and only display first
 * part, but it will perform matching on and output full lines as usual.
 *
 * This can be useful if you want to separate data and representation, for example, a music
 * player wrapper can display only a track title to user, but still supply full filename to
 * the underlying script.
 * https://tools.suckless.org/dmenu/patches/tsv/
 */
#define TSV_PATCH 0

/* This patch prevents dmenu from indenting items at the same level as the prompt length.
 * https://tools.suckless.org/dmenu/patches/vertfull/
 */
#define VERTFULL_PATCH 0

/* Adds extended window manager hints such as _NET_WM_WINDOW_TYPE and _NET_WM_WINDOW_TYPE_DOCK.
 * https://github.com/Baitinq/dmenu/blob/master/patches/dmenu-wm_type.diff
 */
#define WMTYPE_PATCH 0

/* This patch adds the ability to configure dmenu via Xresources. At startup, dmenu will read and
 * apply the resources named below:
 *    dmenu.font          : font or font set
 *    dmenu.background    : normal background color
 *    dmenu.foreground    : normal foreground color
 *    dmenu.selbackground : selected background color
 *    dmenu.selforeground : selected foreground color
 *
 * See patch/xresources.c for more color settings.
 *
 * https://tools.suckless.org/dmenu/patches/xresources/
 */
#define XRESOURCES_PATCH 0

/* This patch adds options for specifying dmenu window position and width.
 * The center patch takes precedence over the XYW patch if enabled.
 * https://tools.suckless.org/dmenu/patches/xyw/
 */
#define XYW_PATCH 0
