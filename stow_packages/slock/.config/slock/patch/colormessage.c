#include <X11/extensions/Xinerama.h>

/* global count to prevent repeated error messages */
int count_error = 0;

static int
readescapedint(const char *str, int *i) {
	int n = 0;
	if (str[*i])
		++*i;
	while(str[*i] && str[*i] != ';' && str[*i] != 'm') {
		n = 10 * n + str[*i] - '0';
		++*i;
	}
	return n;
}

static void
writemessage(Display *dpy, Window win, int screen)
{
	int len, line_len, width, height, s_width, s_height, i, k, tab_size, r, g, b, escaped_int, curr_line_len;
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
	line_len = curr_line_len = 0;
	k = 0;
	for (i = 0; i < len; i++) {
		if (message[i] == '\n') {
			curr_line_len = 0;
			k++;
		} else if (message[i] == 0x1b) {
			while (i < len && message[i] != 'm') {
				i++;
			}
			if (i == len)
				die("slock: unclosed escape sequence\n");
		} else {
			curr_line_len += XTextWidth(fontinfo, message + i, 1);
			if (curr_line_len > line_len)
				line_len = curr_line_len;
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
	width  = (s_width - line_len)/2;

	line_len = 0;
	/* print the text while parsing 24 bit color ANSI escape codes*/
	for (i = k = 0; i < len; i++) {
		switch (message[i]) {
			case '\n':
				line_len = 0;
				while (message[i + 1] == '\t') {
					line_len += tab_size;
					i++;
				}
				k++;
				break;
			case 0x1b:
				i++;
				if (message[i] == '[') {
					escaped_int = readescapedint(message, &i);
					if (escaped_int == 39)
						continue;
					if (escaped_int != 38)
						die("slock: unknown escape sequence%d\n", escaped_int);
					if (readescapedint(message, &i) != 2)
						die("slock: only 24 bit color supported\n");
					r = readescapedint(message, &i) & 0xff;
					g = readescapedint(message, &i) & 0xff;
					b = readescapedint(message, &i) & 0xff;
					XSetForeground(dpy, gc, r << 16 | g << 8 | b);
				} else
					die("slock: unknown escape sequence\n");
				break;
			default:
				XDrawString(dpy, win, gc, width + line_len, height + 20 * k, message + i, 1);
				line_len += XTextWidth(fontinfo, message + i, 1);
		}
	}

	/* xsi should not be NULL anyway if Xinerama is active, but to be safe */
	if (XineramaIsActive(dpy) && xsi != NULL)
		XFree(xsi);
}