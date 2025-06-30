int
width_status(Bar *bar, BarArg *a)
{
	return TEXTWM(stext);
}

int
draw_status(Bar *bar, BarArg *a)
{
	return drw_text(drw, a->x, a->y, a->w, a->h, lrpad / 2, stext, 0, True);
}

int
click_status(Bar *bar, Arg *arg, BarArg *a)
{
	return ClkStatusText;
}

