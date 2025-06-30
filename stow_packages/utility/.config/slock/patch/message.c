#include <X11/extensions/Xinerama.h>

/* global count to prevent repeated error messages */
int count_error = 0;

static void
writemessage(Display *dpy, Window win, int screen)
{
	int len, line_len, width, height, s_width, s_height, i, j, k, tab_replace, tab_size;
	XGCValues gr_values;
	XFontStruct *fontinfo;
	XColor color, dummy;
	XineramaScreenInfo *xsi;
	GC gc;
	fontinfo = XLoadQueryFont(dpy, font_name);

	if (fontinfo == NULL) {
		if (count_error == 0) {
			fprintf(stderr, "slock: Unable to load font \"%s\"\n", font_name);
			fprintf(stderr, "slock: Try listing fonts with 'slock -f'\n");
			count_error++;
		}
		return;
	}

	tab_size = 8 * XTextWidth(fontinfo, " ", 1);

	XAllocNamedColor(dpy, DefaultColormap(dpy, screen),
		text_color, &color, &dummy);

	gr_values.font = fontinfo->fid;
	gr_values.foreground = color.pixel;
	gc=XCreateGC(dpy,win,GCFont+GCForeground, &gr_values);

	/*  To prevent "Uninitialized" warnings. */
	xsi = NULL;

	/*
	 * Start formatting and drawing text
	 */

	len = strlen(message);

	/* Max max line length (cut at '\n') */
	line_len = 0;
	k = 0;
	for (i = j = 0; i < len; i++) {
		if (message[i] == '\n') {
			if (i - j > line_len)
				line_len = i - j;
			k++;
			i++;
			j = i;
		}
	}
	/* If there is only one line */
	if (line_len == 0)
		line_len = len;

	if (XineramaIsActive(dpy)) {
		xsi = XineramaQueryScreens(dpy, &i);
		s_width = xsi[0].width;
		s_height = xsi[0].height;
	} else {
		s_width = DisplayWidth(dpy, screen);
		s_height = DisplayHeight(dpy, screen);
	}

	height = s_height*3/7 - (k*20)/3;
	width  = (s_width - XTextWidth(fontinfo, message, line_len))/2;

	/* Look for '\n' and print the text between them. */
	for (i = j = k = 0; i <= len; i++) {
		/* i == len is the special case for the last line */
		if (i == len || message[i] == '\n') {
			tab_replace = 0;
			while (message[j] == '\t' && j < i) {
				tab_replace++;
				j++;
			}

			XDrawString(dpy, win, gc, width + tab_size*tab_replace, height + 20*k, message + j, i - j);
			while (i < len && message[i] == '\n') {
				i++;
				j = i;
				k++;
			}
		}
	}

	/* xsi should not be NULL anyway if Xinerama is active, but to be safe */
	if (XineramaIsActive(dpy) && xsi != NULL)
		XFree(xsi);
}