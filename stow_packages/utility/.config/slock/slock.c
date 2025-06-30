/* See LICENSE file for license details. */
#define _XOPEN_SOURCE 500
#define LENGTH(X) (sizeof X / sizeof X[0])
#if HAVE_SHADOW_H
#include <shadow.h>
#endif

#include <ctype.h>
#include <errno.h>
#include <grp.h>
#include <pwd.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <X11/extensions/Xrandr.h>
#include <X11/keysym.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#include "patches.h"
#if ALPHA_PATCH
#include <X11/Xatom.h>
#endif // ALPHA_PATCH
#if KEYPRESS_FEEDBACK_PATCH
#include <time.h>
#endif // KEYPRESS_FEEDBACK_PATCH
#if CAPSCOLOR_PATCH
#include <X11/XKBlib.h>
#endif // CAPSCOLOR_PATCH
#if MEDIAKEYS_PATCH
#include <X11/XF86keysym.h>
#endif // MEDIAKEYS_PATCH
#if QUICKCANCEL_PATCH || AUTO_TIMEOUT_PATCH
#include <time.h>
#endif // QUICKCANCEL_PATCH / AUTO_TIMEOUT_PATCH
#if DPMS_PATCH
#include <X11/extensions/dpms.h>
#endif // DPMS_PATCH
#ifdef XINERAMA
#include <X11/extensions/Xinerama.h>
#endif

#include "arg.h"
#include "util.h"

char *argv0;
#if FAILURE_COMMAND_PATCH
int failtrack = 0;
#endif // FAILURE_COMMAND_PATCH

#if AUTO_TIMEOUT_PATCH
static time_t lasttouched;
int runflag = 0;
#endif // AUTO_TIMEOUT_PATCH
#if QUICKCANCEL_PATCH
static time_t locktime;
#endif // QUICKCANCEL_PATCH

enum {
	#if DWM_LOGO_PATCH && !BLUR_PIXELATED_SCREEN_PATCH
	BACKGROUND,
	#endif // DWM_LOGO_PATCH
	INIT,
	INPUT,
	FAILED,
	#if CAPSCOLOR_PATCH
	CAPS,
	#endif // CAPSCOLOR_PATCH
	#if PAMAUTH_PATCH
	PAM,
	#endif // PAMAUTH_PATCH
	#if KEYPRESS_FEEDBACK_PATCH
	BLOCKS,
	#endif // KEYPRESS_FEEDBACK_PATCH
	NUMCOLS
};

#if XRESOURCES_PATCH
/* Xresources preferences */
enum resource_type {
	STRING = 0,
	INTEGER = 1,
	FLOAT = 2
};

typedef struct {
	char *name;
	enum resource_type type;
	void *dst;
} ResourcePref;
#endif // XRESOURCES_PATCH

#if SECRET_PASSWORD_PATCH
typedef struct secretpass secretpass;
struct secretpass {
	char *pass;
	char *command;
};
#endif // SECRET_PASSWORD_PATCH

#include "config.h"

struct lock {
	int screen;
	Window root, win;
	Pixmap pmap;
	#if BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
	Pixmap bgmap;
	#endif // BLUR_PIXELATED_SCREEN_PATCH | BACKGROUND_IMAGE_PATCH
	unsigned long colors[NUMCOLS];
	#if DWM_LOGO_PATCH
	unsigned int x, y;
	unsigned int xoff, yoff, mw, mh;
	Drawable drawable;
	GC gc;
	XRectangle rectangles[LENGTH(rectangles)];
	#endif // DWM_LOGO_PATCH
};

struct xrandr {
	int active;
	int evbase;
	int errbase;
};

#include "patch/include.h"

static void
die(const char *errstr, ...)
{
	va_list ap;

	va_start(ap, errstr);
	vfprintf(stderr, errstr, ap);
	va_end(ap);
	exit(1);
}

#include "patch/include.c"

#ifdef __linux__
#include <fcntl.h>
#include <linux/oom.h>

static void
dontkillme(void)
{
	FILE *f;
	const char oomfile[] = "/proc/self/oom_score_adj";

	if (!(f = fopen(oomfile, "w"))) {
		if (errno == ENOENT)
			return;
		die("slock: fopen %s: %s\n", oomfile, strerror(errno));
	}
	fprintf(f, "%d", OOM_SCORE_ADJ_MIN);
	if (fclose(f)) {
		if (errno == EACCES)
			die("slock: unable to disable OOM killer. "
			    "Make sure to suid or sgid slock.\n");
		else
			die("slock: fclose %s: %s\n", oomfile, strerror(errno));
	}
}
#endif

static const char *
gethash(void)
{
	const char *hash;
	struct passwd *pw;

	/* Check if the current user has a password entry */
	errno = 0;
	if (!(pw = getpwuid(getuid()))) {
		if (errno)
			die("slock: getpwuid: %s\n", strerror(errno));
		else
			die("slock: cannot retrieve password entry\n");
	}
	hash = pw->pw_passwd;

#if HAVE_SHADOW_H
	if (!strcmp(hash, "x")) {
		struct spwd *sp;
		if (!(sp = getspnam(pw->pw_name)))
			die("slock: getspnam: cannot retrieve shadow entry. "
			    "Make sure to suid or sgid slock.\n");
		hash = sp->sp_pwdp;
	}
#else
	if (!strcmp(hash, "*")) {
#ifdef __OpenBSD__
		if (!(pw = getpwuid_shadow(getuid())))
			die("slock: getpwnam_shadow: cannot retrieve shadow entry. "
			    "Make sure to suid or sgid slock.\n");
		hash = pw->pw_passwd;
#else
		die("slock: getpwuid: cannot retrieve shadow entry. "
		    "Make sure to suid or sgid slock.\n");
#endif /* __OpenBSD__ */
	}
#endif /* HAVE_SHADOW_H */

	#if PAMAUTH_PATCH
	/* pam, store user name */
	hash = pw->pw_name;
	#endif // PAMAUTH_PATCH
	return hash;
}

static void
readpw(Display *dpy, struct xrandr *rr, struct lock **locks, int nscreens,
       const char *hash)
{
	XRRScreenChangeNotifyEvent *rre;
	#if PAMAUTH_PATCH
	char buf[32];
	int retval;
	pam_handle_t *pamh;
	#else
	char buf[32], passwd[256], *inputhash;
	#endif // PAMAUTH_PATCH
	int num, screen, running, failure, oldc;
	unsigned int len, color;
	#if AUTO_TIMEOUT_PATCH
	time_t currenttime;
	#endif // AUTO_TIMEOUT_PATCH
	#if CAPSCOLOR_PATCH
	int caps;
	unsigned int indicators;
	#endif // CAPSCOLOR_PATCH
	KeySym ksym;
	XEvent ev;

	len = 0;
	#if CAPSCOLOR_PATCH
	caps = 0;
	#endif // CAPSCOLOR_PATCH
	running = 1;
	failure = 0;
	oldc = INIT;

	#if CAPSCOLOR_PATCH
	if (!XkbGetIndicatorState(dpy, XkbUseCoreKbd, &indicators))
		caps = indicators & 1;

	#endif // CAPSCOLOR_PATCH
	#if AUTO_TIMEOUT_PATCH
	while (running)
	#else
	while (running && !XNextEvent(dpy, &ev))
	#endif // AUTO_TIMEOUT_PATCH
	{
		#if AUTO_TIMEOUT_PATCH
		while (XPending(dpy)) {
			XNextEvent(dpy, &ev);
		#endif // AUTO_TIMEOUT_PATCH
		#if QUICKCANCEL_PATCH
		running = !((time(NULL) - locktime < timetocancel) && (ev.type == MotionNotify));
		#endif // QUICKCANCEL_PATCH
		if (ev.type == KeyPress) {
			#if AUTO_TIMEOUT_PATCH
			time(&lasttouched);
			#endif // AUTO_TIMEOUT_PATCH
			explicit_bzero(&buf, sizeof(buf));
			num = XLookupString(&ev.xkey, buf, sizeof(buf), &ksym, 0);
			if (IsKeypadKey(ksym)) {
				if (ksym == XK_KP_Enter)
					ksym = XK_Return;
				else if (ksym >= XK_KP_0 && ksym <= XK_KP_9)
					ksym = (ksym - XK_KP_0) + XK_0;
			}
			if (IsFunctionKey(ksym) ||
			    IsKeypadKey(ksym) ||
			    IsMiscFunctionKey(ksym) ||
			    IsPFKey(ksym) ||
			    IsPrivateKeypadKey(ksym))
				continue;
			#if TERMINALKEYS_PATCH
			if (ev.xkey.state & ControlMask) {
				switch (ksym) {
				case XK_u:
					ksym = XK_Escape;
					break;
				case XK_m:
					ksym = XK_Return;
					break;
				case XK_j:
					ksym = XK_Return;
					break;
				case XK_h:
					ksym = XK_BackSpace;
					break;
				}
			}
			#endif // TERMINALKEYS_PATCH
			switch (ksym) {
			case XK_Return:
				passwd[len] = '\0';
				errno = 0;

				#if SECRET_PASSWORD_PATCH
				for (int i = 0; i < LENGTH(scom); i++) {
					if (strcmp(scom[i].pass, passwd) == 0) {
						if (system(scom[i].command));
						#if FAILURE_COMMAND_PATCH
						failtrack = -1;
						#endif // FAILURE_COMMAND_PATCH
					}
				}
				#endif // SECRET_PASSWORD_PATCH

				#if PAMAUTH_PATCH
				retval = pam_start(pam_service, hash, &pamc, &pamh);
				color = PAM;
				for (screen = 0; screen < nscreens; screen++) {
					#if DWM_LOGO_PATCH
					drawlogo(dpy, locks[screen], color);
					#elif BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
					if (locks[screen]->bgmap)
						XSetWindowBackgroundPixmap(dpy, locks[screen]->win, locks[screen]->bgmap);
					else
						XSetWindowBackground(dpy, locks[screen]->win, locks[screen]->colors[0]);
					XClearWindow(dpy, locks[screen]->win);
					#else
					XSetWindowBackground(dpy, locks[screen]->win, locks[screen]->colors[color]);
					XClearWindow(dpy, locks[screen]->win);
					XRaiseWindow(dpy, locks[screen]->win);
					#endif // BLUR_PIXELATED_SCREEN_PATCH

				}
				XSync(dpy, False);

				if (retval == PAM_SUCCESS)
					retval = pam_authenticate(pamh, 0);
				if (retval == PAM_SUCCESS)
					retval = pam_acct_mgmt(pamh, 0);

				running = 1;
				if (retval == PAM_SUCCESS)
					running = 0;
				else
					fprintf(stderr, "slock: %s\n", pam_strerror(pamh, retval));
				pam_end(pamh, retval);
				#else
				if (!(inputhash = crypt(passwd, hash)))
					fprintf(stderr, "slock: crypt: %s\n", strerror(errno));
				else
					running = !!strcmp(inputhash, hash);
				#endif // PAMAUTH_PATCH
				if (running) {
					XBell(dpy, 100);
					failure = 1;
					#if FAILURE_COMMAND_PATCH
					failtrack++;

					if (failtrack >= failcount && failcount != 0) {
						system(failcommand);
					}
					#endif // FAILURE_COMMAND_PATCH
				}
				explicit_bzero(&passwd, sizeof(passwd));
				len = 0;
				break;
			case XK_Escape:
				explicit_bzero(&passwd, sizeof(passwd));
				len = 0;
				break;
			case XK_BackSpace:
				if (len)
					passwd[--len] = '\0';
				break;
			#if CAPSCOLOR_PATCH
			case XK_Caps_Lock:
				caps = !caps;
				break;
			#endif // CAPSCOLOR_PATCH
			#if MEDIAKEYS_PATCH
			case XF86XK_AudioLowerVolume:
			case XF86XK_AudioMute:
			case XF86XK_AudioRaiseVolume:
			case XF86XK_AudioPlay:
			case XF86XK_AudioStop:
			case XF86XK_AudioPrev:
			case XF86XK_AudioNext:
				XSendEvent(dpy, DefaultRootWindow(dpy), True, KeyPressMask, &ev);
				break;
			#endif // MEDIAKEYS_PATCH
			default:
				#if CONTROLCLEAR_PATCH
				if (controlkeyclear && iscntrl((int)buf[0]))
					continue;
				if (num && (len + num < sizeof(passwd)))
				#else
				if (num && !iscntrl((int)buf[0]) &&
				    (len + num < sizeof(passwd)))
				#endif // CONTROLCLEAR_PATCH
				{
					memcpy(passwd + len, buf, num);
					len += num;
				}
				#if KEYPRESS_FEEDBACK_PATCH
				if (blocks_enabled)
					for (screen = 0; screen < nscreens; screen++)
						draw_key_feedback(dpy, locks, screen);
				#endif // KEYPRESS_FEEDBACK_PATCH
				break;
			}
			#if CAPSCOLOR_PATCH
			color = len ? (caps ? CAPS : INPUT) : (failure || failonclear ? FAILED : INIT);
			#else
			color = len ? INPUT : ((failure || failonclear) ? FAILED : INIT);
			#endif // CAPSCOLOR_PATCH
			if (running && oldc != color) {
				for (screen = 0; screen < nscreens; screen++) {
					#if DWM_LOGO_PATCH
					drawlogo(dpy, locks[screen], color);
					#elif BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
					if (locks[screen]->bgmap)
						XSetWindowBackgroundPixmap(dpy, locks[screen]->win, locks[screen]->bgmap);
					else
						XSetWindowBackground(dpy, locks[screen]->win, locks[screen]->colors[0]);
					XClearWindow(dpy, locks[screen]->win);
					#else
					XSetWindowBackground(dpy,
					                     locks[screen]->win,
					                     locks[screen]->colors[color]);
					XClearWindow(dpy, locks[screen]->win);
					#endif // BLUR_PIXELATED_SCREEN_PATCH
					#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
					writemessage(dpy, locks[screen]->win, screen);
					#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
				}
				oldc = color;
			}
		} else if (rr->active && ev.type == rr->evbase + RRScreenChangeNotify) {
			rre = (XRRScreenChangeNotifyEvent*)&ev;
			for (screen = 0; screen < nscreens; screen++) {
				if (locks[screen]->win == rre->window) {
					if (rre->rotation == RR_Rotate_90 ||
					    rre->rotation == RR_Rotate_270)
						XResizeWindow(dpy, locks[screen]->win,
						              rre->height, rre->width);
					else
						XResizeWindow(dpy, locks[screen]->win,
						              rre->width, rre->height);
					XClearWindow(dpy, locks[screen]->win);
					break;
				}
			}
		} else {
			for (screen = 0; screen < nscreens; screen++)
				XRaiseWindow(dpy, locks[screen]->win);
		}

		#if AUTO_TIMEOUT_PATCH
		}

		time(&currenttime);

		if (currenttime >= lasttouched + timeoffset) {
			if (!runonce || !runflag) {
				runflag = 1;
				system(command);
			}
			lasttouched = currenttime;
		}
		usleep(50); // artificial sleep for 50ms
		#endif // AUTO_TIMEOUT_PATCH
	}
}

static struct lock *
lockscreen(Display *dpy, struct xrandr *rr, int screen)
{
	char curs[] = {0, 0, 0, 0, 0, 0, 0, 0};
	int i, ptgrab, kbgrab;
	struct lock *lock;
	XColor color, dummy;
	XSetWindowAttributes wa;
	Cursor invisible;
	#if DWM_LOGO_PATCH
	#ifdef XINERAMA
	XineramaScreenInfo *info;
	int n;
	#endif
	#endif // DWM_LOGO_PATCH
	#if AUTO_TIMEOUT_PATCH
	time(&lasttouched);
	#endif // AUTO_TIMEOUT_PATCH

	if (dpy == NULL || screen < 0 || !(lock = malloc(sizeof(struct lock))))
		return NULL;

	lock->screen = screen;
	lock->root = RootWindow(dpy, lock->screen);

	#if BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
	render_lock_image(dpy, lock, image);
	#endif // BLUR_PIXELATED_SCREEN_PATCH | BACKGROUND_IMAGE_PATCH

	for (i = 0; i < NUMCOLS; i++) {
		XAllocNamedColor(dpy, DefaultColormap(dpy, lock->screen),
		                 colorname[i], &color, &dummy);
		lock->colors[i] = color.pixel;
	}

	#if DWM_LOGO_PATCH
	lock->x = DisplayWidth(dpy, lock->screen);
	lock->y = DisplayHeight(dpy, lock->screen);
	#ifdef XINERAMA
	if ((info = XineramaQueryScreens(dpy, &n))) {
		lock->xoff = info[0].x_org;
		lock->yoff = info[0].y_org;
		lock->mw = info[0].width;
		lock->mh = info[0].height;
	} else
	#endif // XINERAMA
	{
		lock->xoff = lock->yoff = 0;
		lock->mw = lock->x;
		lock->mh = lock->y;
	}
	lock->drawable = XCreatePixmap(dpy, lock->root, lock->x, lock->y, DefaultDepth(dpy, screen));
	lock->gc = XCreateGC(dpy, lock->root, 0, NULL);
	XSetLineAttributes(dpy, lock->gc, 1, LineSolid, CapButt, JoinMiter);
	#endif // DWM_LOGO_PATCH

	/* init */
	wa.override_redirect = 1;
	#if DWM_LOGO_PATCH && BLUR_PIXELATED_SCREEN_PATCH
	#elif DWM_LOGO_PATCH
	wa.background_pixel = lock->colors[BACKGROUND];
	#else
	wa.background_pixel = lock->colors[INIT];
	#endif // DWM_LOGO_PATCH
	lock->win = XCreateWindow(dpy, lock->root, 0, 0,
	                          #if DWM_LOGO_PATCH
	                          lock->x,
	                          lock->y,
	                          #else
	                          DisplayWidth(dpy, lock->screen),
	                          DisplayHeight(dpy, lock->screen),
	                          #endif // DWM_LOGO_PATCH
	                          0, DefaultDepth(dpy, lock->screen),
	                          CopyFromParent,
	                          DefaultVisual(dpy, lock->screen),
	                          CWOverrideRedirect | CWBackPixel, &wa);
	#if BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
	if (lock->bgmap)
		XSetWindowBackgroundPixmap(dpy, lock->win, lock->bgmap);
	#endif // BLUR_PIXELATED_SCREEN_PATCH | BACKGROUND_IMAGE_PATCH
	lock->pmap = XCreateBitmapFromData(dpy, lock->win, curs, 8, 8);
	invisible = XCreatePixmapCursor(dpy, lock->pmap, lock->pmap,
	                                &color, &color, 0, 0);
	XDefineCursor(dpy, lock->win, invisible);

	#if DWM_LOGO_PATCH
	resizerectangles(lock);
	#endif // DWM_LOGO_PATCH

	/* Try to grab mouse pointer *and* keyboard for 600ms, else fail the lock */
	for (i = 0, ptgrab = kbgrab = -1; i < 6; i++) {
		if (ptgrab != GrabSuccess) {
			ptgrab = XGrabPointer(dpy, lock->root, False,
			                      ButtonPressMask | ButtonReleaseMask |
			                      PointerMotionMask, GrabModeAsync,
			                      GrabModeAsync, None,
			                      #if UNLOCKSCREEN_PATCH
			                      None,
			                      #else
			                      invisible,
			                      #endif // UNLOCKSCREEN_PATCH
			                      CurrentTime);
		}
		if (kbgrab != GrabSuccess) {
			kbgrab = XGrabKeyboard(dpy, lock->root, True,
			                       GrabModeAsync, GrabModeAsync, CurrentTime);
		}

		/* input is grabbed: we can lock the screen */
		if (ptgrab == GrabSuccess && kbgrab == GrabSuccess) {
			#if !UNLOCKSCREEN_PATCH
			XMapRaised(dpy, lock->win);
			#endif // UNLOCKSCREEN_PATCH
			if (rr->active)
				XRRSelectInput(dpy, lock->win, RRScreenChangeNotifyMask);

			XSelectInput(dpy, lock->root, SubstructureNotifyMask);
			#if QUICKCANCEL_PATCH
			locktime = time(NULL);
			#endif // QUICKCANCEL_PATCH
			#if DWM_LOGO_PATCH
			drawlogo(dpy, lock, INIT);
			#endif // DWM_LOGO_PATCH
			#if ALPHA_PATCH
			unsigned int opacity = (unsigned int)(alpha * 0xffffffff);
			XChangeProperty(dpy, lock->win, XInternAtom(dpy, "_NET_WM_WINDOW_OPACITY", False), XA_CARDINAL, 32, PropModeReplace, (unsigned char *)&opacity, 1L);
			XSync(dpy, False);
			#endif // ALPHA_PATCH
			return lock;
		}

		/* retry on AlreadyGrabbed but fail on other errors */
		if ((ptgrab != AlreadyGrabbed && ptgrab != GrabSuccess) ||
		    (kbgrab != AlreadyGrabbed && kbgrab != GrabSuccess))
			break;

		usleep(100000);
	}

	/* we couldn't grab all input: fail out */
	if (ptgrab != GrabSuccess)
		fprintf(stderr, "slock: unable to grab mouse pointer for screen %d\n",
		        screen);
	if (kbgrab != GrabSuccess)
		fprintf(stderr, "slock: unable to grab keyboard for screen %d\n",
		        screen);
	return NULL;
}

static void
usage(void)
{
	#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
	die("usage: slock [-v] [-f] [-m message] [cmd [arg ...]]\n");
	#else
	die("usage: slock [-v] [cmd [arg ...]]\n");
	#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
}

int
main(int argc, char **argv) {
	struct xrandr rr;
	struct lock **locks;
	struct passwd *pwd;
	struct group *grp;
	uid_t duid;
	gid_t dgid;
	const char *hash;
	Display *dpy;
	int s, nlocks, nscreens;
	#if DPMS_PATCH
	CARD16 standby, suspend, off;
	#endif // DPMS_PATCH
	#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
	int i, count_fonts;
	char **font_names;
	#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
	ARGBEGIN {
	case 'v':
		fprintf(stderr, "slock-"VERSION"\n");
		return 0;
	#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
	case 'm':
		message = EARGF(usage());
		break;
	case 'f':
		if (!(dpy = XOpenDisplay(NULL)))
			die("slock: cannot open display\n");
		font_names = XListFonts(dpy, "*", 10000 /* list 10000 fonts*/, &count_fonts);
		for (i=0; i<count_fonts; i++) {
			fprintf(stderr, "%s\n", *(font_names+i));
		}
		return 0;
	#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
	default:
		usage();
	} ARGEND

	/* validate drop-user and -group */
	errno = 0;
	if (!(pwd = getpwnam(user)))
		die("slock: getpwnam %s: %s\n", user,
		    errno ? strerror(errno) : "user entry not found");
	duid = pwd->pw_uid;
	errno = 0;
	if (!(grp = getgrnam(group)))
		die("slock: getgrnam %s: %s\n", group,
		    errno ? strerror(errno) : "group entry not found");
	dgid = grp->gr_gid;

#ifdef __linux__
	dontkillme();
#endif

	#if PAMAUTH_PATCH
	/* the contents of hash are used to transport the current user name */
	#endif // PAMAUTH_PATCH
	hash = gethash();
	errno = 0;
	#if !PAMAUTH_PATCH
	if (!crypt("", hash))
		die("slock: crypt: %s\n", strerror(errno));
	#endif // PAMAUTH_PATCH

	if (!(dpy = XOpenDisplay(NULL)))
		die("slock: cannot open display\n");

	/* drop privileges */
	if (setgroups(0, NULL) < 0)
		die("slock: setgroups: %s\n", strerror(errno));
	if (setgid(dgid) < 0)
		die("slock: setgid: %s\n", strerror(errno));
	if (setuid(duid) < 0)
		die("slock: setuid: %s\n", strerror(errno));

	#if XRESOURCES_PATCH
	config_init(dpy);
	#endif // XRESOURCES_PATCH

	#if BLUR_PIXELATED_SCREEN_PATCH || BACKGROUND_IMAGE_PATCH
	create_lock_image(dpy);
	#endif // BLUR_PIXELATED_SCREEN_PATCH | BACKGROUND_IMAGE_PATCH

	#if KEYPRESS_FEEDBACK_PATCH
	time_t t;
	srand((unsigned) time(&t));
	#endif // KEYPRESS_FEEDBACK_PATCH

	/* check for Xrandr support */
	rr.active = XRRQueryExtension(dpy, &rr.evbase, &rr.errbase);

	/* get number of screens in display "dpy" and blank them */
	nscreens = ScreenCount(dpy);
	if (!(locks = calloc(nscreens, sizeof(struct lock *))))
		die("slock: out of memory\n");
	for (nlocks = 0, s = 0; s < nscreens; s++) {
		if ((locks[s] = lockscreen(dpy, &rr, s)) != NULL) {
			#if MESSAGE_PATCH || COLOR_MESSAGE_PATCH
			writemessage(dpy, locks[s]->win, s);
			#endif // MESSAGE_PATCH | COLOR_MESSAGE_PATCH
			nlocks++;
		} else {
			break;
		}
	}
	XSync(dpy, 0);

	/* did we manage to lock everything? */
	if (nlocks != nscreens)
		return 1;

	#if DPMS_PATCH
	/* DPMS magic to disable the monitor */
	if (!DPMSCapable(dpy))
		die("slock: DPMSCapable failed\n");
	if (!DPMSEnable(dpy))
		die("slock: DPMSEnable failed\n");
	if (!DPMSGetTimeouts(dpy, &standby, &suspend, &off))
		die("slock: DPMSGetTimeouts failed\n");
	if (!standby || !suspend || !off)
		die("slock: at least one DPMS variable is zero\n");
	if (!DPMSSetTimeouts(dpy, monitortime, monitortime, monitortime))
		die("slock: DPMSSetTimeouts failed\n");

	XSync(dpy, 0);
	#endif // DPMS_PATCH

	/* run post-lock command */
	if (argc > 0) {
		switch (fork()) {
		case -1:
			die("slock: fork failed: %s\n", strerror(errno));
		case 0:
			if (close(ConnectionNumber(dpy)) < 0)
				die("slock: close: %s\n", strerror(errno));
			execvp(argv[0], argv);
			fprintf(stderr, "slock: execvp %s: %s\n", argv[0], strerror(errno));
			_exit(1);
		}
	}

	/* everything is now blank. Wait for the correct password */
	readpw(dpy, &rr, locks, nscreens, hash);
	#if DPMS_PATCH
	/* reset DPMS values to inital ones */
	DPMSSetTimeouts(dpy, standby, suspend, off);
	XSync(dpy, 0);
	#endif // DPMS_PATCH

	#if DWM_LOGO_PATCH
	for (nlocks = 0, s = 0; s < nscreens; s++) {
		XFreePixmap(dpy, locks[s]->drawable);
		XFreeGC(dpy, locks[s]->gc);
	}

	XSync(dpy, 0);
	XCloseDisplay(dpy);
	#endif // DWM_LOGO_PATCH

	return 0;
}
