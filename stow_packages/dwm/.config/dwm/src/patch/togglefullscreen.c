void
togglefullscreen(const Arg *arg)
{
	Client *c = selmon->sel;
	if (!c)
		return;

	setfullscreen(c, !c->isfullscreen);
}

