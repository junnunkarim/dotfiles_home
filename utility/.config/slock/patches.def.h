/*
 * This file contains patch control flags.
 *
 * In principle you should be able to mix and match any patches
 * you may want. In cases where patches are logically incompatible
 * one patch may take precedence over the other as noted in the
 * relevant descriptions.
 */

/* Patches */

/* This patch enables transparency for slock. This is intended to be combined
 * with a compositor that can blur the transparent background.
 * Extrapolated from https://github.com/khuedoan/slock
 * https://github.com/khuedoan/slock/commit/5e7a95b50fd72efcf2a40d487278749a17cbb146
 */
#define ALPHA_PATCH 0

/* This patch allows for a command to be executed after a specified time of inactivity.
 * https://tools.suckless.org/slock/patches/auto-timeout/
 */
#define AUTO_TIMEOUT_PATCH 0

/* This patch adds a background image for slock.
 * This patch depends on the Imlib2 library, uncomment the relevant line in
 * config.mk when enabling this patch.
 * This patch is a variant of the blur pixelated screen patch and takes precedence over that.
 * https://tools.suckless.org/slock/patches/background-image/
 */
#define BACKGROUND_IMAGE_PATCH 0

/* This patch sets the lockscreen picture to a blured or pixelated screenshot.
 * This patch depends on the Imlib2 library, uncomment the relevant line in
 * config.mk when enabling this patch.
 * The background image patch takes precedence over this patch.
 * https://tools.suckless.org/slock/patches/blur-pixelated-screen/
 */
#define BLUR_PIXELATED_SCREEN_PATCH 0

/* This patch introduces an additional color to indicate the state of Caps Lock.
 * https://tools.suckless.org/slock/patches/capscolor/
 */
#define CAPSCOLOR_PATCH 0

/* Based on the message patch this patch lets you add a message to your lock screen using 24 bit
 * color ANSI escape codes.
 *
 * You can place a default message in config.h and you can also pass a message with the -m command
 * line option.
 *
 * Practical example:
 *    slock -m "$(printf "text colored \x1b[38;2;0;255;0m green\x1b[39m\n")"
 *
 * If you enable this then you also need to add the -lXinerama library to the LIBS
 * configuration in config.mk. Look for and uncomment the XINERAMA placeholder.
 *
 * https://tools.suckless.org/slock/patches/colormessage/
 */
#define COLOR_MESSAGE_PATCH 0

/* Adds an additional configuration parameter, controlkeyclear. When set to 1, slock will no
 * longer change to the failure color if a control key is pressed while the buffer is empty.
 * This may be useful if, for example, you wake your monitor up by pressing a control key
 * and don't want to spoil the detection of failed unlocking attempts.
 * https://tools.suckless.org/slock/patches/control-clear/
 */
#define CONTROLCLEAR_PATCH 0

/* This patch interacts with the Display Power Signaling and automatically shuts down
 * the monitor after a configurable amount of seconds.
 * The monitor will automatically be activated by pressing a key or moving the mouse
 * and the password can be entered then.
 * https://tools.suckless.org/slock/patches/dpms/
 */
#define DPMS_PATCH 0

/* This patch draws the dwm logo which changes color based on the state.
 * https://tools.suckless.org/slock/patches/dwmlogo/
 */
#define DWM_LOGO_PATCH 0

/* This patch allows for a command to be run after a specified number of incorrect attempts.
 * https://tools.suckless.org/slock/patches/failure-command/
 */
#define FAILURE_COMMAND_PATCH 0

/* Draws random blocks on the screen to display keypress feedback.
 * https://tools.suckless.org/slock/patches/keypress-feedback/
 * https://patch-diff.githubusercontent.com/raw/phenax/bslock/pull/2.diff
 */
#define KEYPRESS_FEEDBACK_PATCH 0

/* This patch allows media keys to be used while the screen is locked. Allows for volume
 * to be adjusted or to skip to the next song without having to unlock the screen first.
 * https://tools.suckless.org/slock/patches/mediakeys/
 */
#define MEDIAKEYS_PATCH 0

/* This patch lets you add a message to your lock screen. You can place a default message
 * in config.h and you can also pass a message with the -m command line option.
 * If you enable this then you also need to add the -lXinerama library to the LIBS
 * configuration in config.mk. Look for and uncomment the XINERAMA placeholder.
 * https://tools.suckless.org/slock/patches/message/
 */
#define MESSAGE_PATCH 0

/* Replaces shadow support with PAM authentication support.
 * Change variable pam_service in config.def.h to the corresponding PAM service.
 * The default configuration is for ArchLinux's login service.
 * If you enable this then you also need to add the -lpam library to the LIBS configuration
 * in config.mk. Look for and uncomment the PAM placeholder.
 * https://tools.suckless.org/slock/patches/pam_auth/
 */
#define PAMAUTH_PATCH 0

/* Cancel slock by moving the mouse within a certain time-period after slock started.
 * The time-period can be defined in seconds with the setting timetocancel in the config.h.
 * This can be useful if you forgot to disable xautolock during an activity that requires
 * no input (e.g. reading text, watching video, etc.).
 * https://tools.suckless.org/slock/patches/quickcancel/
 */
#define QUICKCANCEL_PATCH 0

/* This patch allows for commands to be executed when the user enters special passwords.
 * https://tools.suckless.org/slock/patches/secret-password/
 */
#define SECRET_PASSWORD_PATCH 0

/* Adds key commands that are commonly used in terminal applications (in particular the
 * login prompt) to slock.
 * https://tools.suckless.org/slock/patches/terminalkeys/
 */
#define TERMINALKEYS_PATCH 0

/* This patch keeps the screen unlocked but keeps the input locked. That is, the screen
 * is not affected by slock, but users will not be able to interact with the X session
 * unless they enter the correct password.
 * https://tools.suckless.org/slock/patches/unlock_screen/
 */
#define UNLOCKSCREEN_PATCH 0

/* This patch adds the ability to get colors via Xresources.
 * https://tools.suckless.org/slock/patches/xresources/
 */
#define XRESOURCES_PATCH 0
