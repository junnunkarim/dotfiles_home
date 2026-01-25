/* Patches */
#if BACKGROUND_IMAGE_PATCH
#include "background_image.c"
#elif BLUR_PIXELATED_SCREEN_PATCH
#include "blur_pixelated_screen.c"
#endif

#if COLOR_MESSAGE_PATCH
#include "colormessage.c"
#elif MESSAGE_PATCH
#include "message.c"
#endif

#if DWM_LOGO_PATCH
#include "dwmlogo.c"
#endif

#if KEYPRESS_FEEDBACK_PATCH
#include "keypress_feedback.c"
#endif

#if PAMAUTH_PATCH
#include "pamauth.c"
#endif

#if XRESOURCES_PATCH
#include "xresources.c"
#endif