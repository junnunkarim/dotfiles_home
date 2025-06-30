static Arg
shift(const Arg *arg, int clients)
{
	Arg shifted;
	Client *c;
	unsigned int tagmask = 0;

	shifted.ui = selmon->tagset[selmon->seltags];

	for (c = selmon->clients; c && clients; c = c->next) {
		if (c == selmon->sel)
			continue;
		tagmask |= c->tags;
	}

	do {
		if (arg->i > 0) // left circular shift
			shifted.ui = (shifted.ui << arg->i) | (shifted.ui >> (NUMTAGS - arg->i));
		else // right circular shift
			shifted.ui = (shifted.ui >> -arg->i) | (shifted.ui << (NUMTAGS + arg->i));
	} while (tagmask && !(shifted.ui & tagmask));

	return shifted;
}
