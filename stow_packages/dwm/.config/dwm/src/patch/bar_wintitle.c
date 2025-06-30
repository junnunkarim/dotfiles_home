int
width_wintitle(Bar *bar, BarArg *a)
{
	return a->w;
}

int
draw_wintitle(Bar *bar, BarArg *a)
{
	int x = a->x + lrpad / 2, w = a->w - lrpad;
	Monitor *m = bar->mon;
	Client *c = m->sel;

	if (!c) {
		drw_setscheme(drw, scheme[SchemeTitleNorm]);
		drw_rect(drw, x, a->y, w, a->h, 1, 1);
		return 0;
	}

	int tpad = lrpad / 2;
	int cpad = 0;
	int tx = x;
	int tw = w;

	drw_setscheme(drw, scheme[m == selmon ? SchemeTitleSel : SchemeTitleNorm]);
	XSetErrorHandler(xerrordummy);

	if (w <= TEXTW("A") - lrpad + tpad) // reduce text padding if wintitle is too small
		tpad = (w - TEXTW("A") + lrpad < 0 ? 0 : (w - TEXTW("A") + lrpad) / 2);
	else if (TEXTW(c->name) < w)
		cpad = (w - TEXTW(c->name)) / 2;

	XSetForeground(drw->dpy, drw->gc, drw->scheme[ColBg].pixel);
	XFillRectangle(drw->dpy, drw->drawable, drw->gc, x, a->y, w, a->h);

	/* Apply center padding, if any */
	tx += cpad;
	tw -= cpad;

	tx += tpad;
	tw -= lrpad;

	drw_text(drw, tx, a->y, tw, a->h, 0, c->name, 0, False);

	XSync(dpy, False);
	XSetErrorHandler(xerror);
	drawstateindicator(m, c, 1, x, a->y, w, a->h, 0, 0, c->isfixed);
	return 1;
}

int
click_wintitle(Bar *bar, Arg *arg, BarArg *a)
{
	return ClkWinTitle;
}

