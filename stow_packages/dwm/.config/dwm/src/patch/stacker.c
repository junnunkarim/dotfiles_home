void
focusstack(const Arg *arg)
{
	int i = stackpos(arg);
	Client *c, *p;

	if (i < 0)
 		return;

	if (!selmon->sel)
		return;

	for (p = NULL, c = selmon->clients; c && (i || !ISVISIBLE(c) || HIDDEN(c));
		i -= (ISVISIBLE(c) && !HIDDEN(c) ? 1 : 0), p = c, c = c->next);
	focus(c ? c : p);
	restack(selmon);
}

void
pushstack(const Arg *arg)
{
	int i = stackpos(arg);
	Client *sel = selmon->sel, *c, *p;

	if (i < 0)
		return;
	else if (i == 0) {
		detach(sel);
		attach(sel);
	}
	else {
		for (p = NULL, c = selmon->clients; c; p = c, c = c->next)
			if (!(i -= (ISVISIBLE(c) && !HIDDEN(c) && c != sel)))
				break;
		c = c ? c : p;
		detach(sel);
		sel->next = c->next;
		c->next = sel;
	}
	arrange(selmon);
}

int
stackpos(const Arg *arg)
{
	int n, i;
	Client *c, *l;

	if (!selmon->clients)
		return -1;

	if (arg->i == PREVSEL) {
		for (l = selmon->stack; l && (!ISVISIBLE(l) || HIDDEN(l) || l == selmon->sel); l = l->snext);
		if (!l)
			return -1;
		for (i = 0, c = selmon->clients; c != l; i += (ISVISIBLE(c) && !HIDDEN(c) ? 1 : 0), c = c->next);
		return i;
	}
	else if (ISINC(arg->i)) {
		if (!selmon->sel)
			return -1;
		for (i = 0, c = selmon->clients; c != selmon->sel; i += (ISVISIBLE(c) && !HIDDEN(c) ? 1 : 0), c = c->next);
		for (n = i; c; n += (ISVISIBLE(c) && !HIDDEN(c) ? 1 : 0), c = c->next);
		return MOD(i + GETINC(arg->i), n);
	}
	else if (arg->i < 0) {
		for (i = 0, c = selmon->clients; c; i += (ISVISIBLE(c) && !HIDDEN(c) ? 1 : 0), c = c->next);
		return MAX(i + arg->i, 0);
	}
	else
		return arg->i;
}

