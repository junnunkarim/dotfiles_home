static int combo = 0;

void
keyrelease(XEvent *e)
{
	combo = 0;
}

void
combotag(const Arg *arg)
{
	if (selmon->sel && arg->ui & TAGMASK) {
		if (selmon->sel->switchtag)
			selmon->sel->switchtag = 0;
		if (combo) {
			selmon->sel->tags |= arg->ui & TAGMASK;
		} else {
			combo = 1;
			selmon->sel->tags = arg->ui & TAGMASK;
		}
		arrange(selmon);
		focus(NULL);
	}
}

void
comboview(const Arg *arg)
{
	if (combo) {
		view(&((Arg) { .ui = selmon->tagset[selmon->seltags] | (arg->ui & TAGMASK) }));
	} else {
		combo = 1;
		view(arg);
	}
}
