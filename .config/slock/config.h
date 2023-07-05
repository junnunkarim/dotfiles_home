/* user and group to drop privileges to */
static const char *user  = "dragoonfx";
static const char *group = "nobody"; // use "nobody" for arch

static const char *colorname[NUMCOLS] = {
	#if DWM_LOGO_PATCH && !BLUR_PIXELATED_SCREEN_PATCH
	[BACKGROUND] =  "#2d2d2d", /* after initialization */
	#endif // DWM_LOGO_PATCH
	[INIT] =   "#81a1c1",     /* after initialization */
	[INPUT] =  "#a3be8c",   /* during input */
	[FAILED] = "#bf616a",   /* wrong password */
	#if CAPSCOLOR_PATCH
	[CAPS] =   "red",       /* CapsLock on */
	#endif // CAPSCOLOR_PATCH
	#if PAMAUTH_PATCH
	[PAM] =    "#9400D3",   /* waiting for PAM */
	#endif // PAMAUTH_PATCH
	#if KEYPRESS_FEEDBACK_PATCH
	[BLOCKS] = "#d08770",   /* key feedback block */
	#endif // KEYPRESS_FEEDBACK_PATCH
};

#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
/* default message */
static const char * message = "Suckless: Software that sucks less.";

/* text color */
static const char * text_color = "#ebdbb2";

/* text size (must be a valid size) */
static const char * font_name = "Iosevka Nerd Font Mono:style=Medium:size=18";
#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH

#if BACKGROUND_IMAGE_PATCH
/* Background image path, should be available to the user above */
static const char * background_image = ".config/wallpaper/pixelart_night_train_cozy_gas_gruvbox_RoyalNaym.png";
#endif // BACKGROUND_IMAGE_PATCH

#if DWM_LOGO_PATCH
/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 75;
static const int logow = 12;   /* grid width and height for right center alignment*/
static const int logoh = 6;

static XRectangle rectangles[] = {
   /* x    y   w   h */
   { 0,    3,  1,  3 },
   { 1,    3,  2,  1 },
   { 0,    5,  8,  1 },
   { 3,    0,  1,  5 },
   { 5,    3,  1,  2 },
   { 7,    3,  1,  2 },
   { 8,    3,  4,  1 },
   { 9,    4,  1,  2 },
   { 11,   4,  1,  2 },
};
#endif // DWM_LOGO_PATCH

#if XRESOURCES_PATCH
/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		#if DWM_LOGO_PATCH && !BLUR_PIXELATED_SCREEN_PATCH
		{ "background",   STRING,  &colorname[BACKGROUND] },
		#endif //DWM_LOGO_PATCH
		#if BACKGROUND_IMAGE_PATCH
		{ "bg_image",     STRING,  &background_image },
		#endif // BACKGROUND_IMAGE_PATCH
		{ "locked",       STRING,  &colorname[INIT] },
		{ "input",        STRING,  &colorname[INPUT] },
		{ "failed",       STRING,  &colorname[FAILED] },
		#if CAPSCOLOR_PATCH
		{ "capslock",     STRING,  &colorname[CAPS] },
		#endif // CAPSCOLOR_PATCH
		#if PAMAUTH_PATCH
		{ "pamauth",      STRING,  &colorname[PAM] },
		#endif // PAMAUTH_PATCH
		#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
		{ "message",      STRING,  &message },
		{ "text_color",   STRING,  &text_color },
		{ "font_name",    STRING,  &font_name },
		#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
};
#endif // XRESOURCES_PATCH

#if ALPHA_PATCH
/* lock screen opacity */
static const float alpha = 0.9;
#endif // ALPHA_PATCH

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

#if AUTO_TIMEOUT_PATCH
/* length of time (seconds) until */
static const int timeoffset = 60;

/* should [command] be run only once? */
static const int runonce = 0;

/* command to be run after [time] has passed */
static const char *command = "doas poweroff";
#endif // AUTO_TIMEOUT_PATCH

#if FAILURE_COMMAND_PATCH
/* number of failed password attempts until failcommand is executed.
   Set to 0 to disable */
static const int failcount = 0;

/* command to be executed after [failcount] failed password attempts */
static const char *failcommand = "shutdown";
#endif // FAILURE_COMMAND_PATCH

#if SECRET_PASSWORD_PATCH
static const secretpass scom[] = {
	/* Password             command */
	{ "shutdown",           "doas poweroff"},
};
#endif // SECRET_PASSWORD_PATCH

#if BLUR_PIXELATED_SCREEN_PATCH
/* Enable blur */
#define BLUR
/* Set blur radius */
static const int blurRadius = 5;
/* Enable Pixelation */
//#define PIXELATION
/* Set pixelation radius */
static const int pixelSize = 10;
#endif // BLUR_PIXELATED_SCREEN_PATCH

#if CONTROLCLEAR_PATCH
/* allow control key to trigger fail on clear */
static const int controlkeyclear = 0;
#endif // CONTROLCLEAR_PATCH

#if DPMS_PATCH
/* time in seconds before the monitor shuts down */
static const int monitortime = 5;
#endif // DPMS_PATCH

#if KEYPRESS_FEEDBACK_PATCH
static short int blocks_enabled = 1; // 0 = don't show blocks
static const int blocks_width = 0; // 0 = full width
static const int blocks_height = 10;

// position
static const int blocks_x = 0;
static const int blocks_y = 0;

// Number of blocks
static const int blocks_count = 10;
#endif // KEYPRESS_FEEDBACK_PATCH

#if PAMAUTH_PATCH
/* PAM service that's used for authentication */
static const char* pam_service = "login";
#endif // PAMAUTH_PATCH

#if QUICKCANCEL_PATCH
/* time in seconds to cancel lock with mouse movement */
static const int timetocancel = 4;
#endif // QUICKCANCEL_PATCH
