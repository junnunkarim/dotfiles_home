static char *expected;
#if MULTI_SELECTION_PATCH
void
expect(char *expect, XKeyEvent *ev)
{
	if (sel && expected && strstr(expected, expect)) {
		if (expected && sel && !(ev->state & ShiftMask))
			puts(expect);
		for (int i = 0; i < selidsize; i++)
			if (selid[i] != -1 && (!sel || sel->id != selid[i]))
				puts(items[selid[i]].text);
		if (sel && !(ev->state & ShiftMask)) {
			puts(sel->text);
		} else
			puts(text);
		cleanup();
		exit(1);
	} else if (!sel && expected && strstr(expected, expect)) {
		puts(expect);
		cleanup();
		exit(1);
	}
}
#else
void
expect(char *expect, XKeyEvent *ignored)
{
	if (sel && expected && strstr(expected, expect)) {
		puts(expect);
		puts(sel->text);
		cleanup();
		exit(1);
	} else if (!sel && expected && strstr(expected, expect)){
		puts(expect);
		cleanup();
		exit(1);
	}
}
#endif // MULTI_SELECTION_PATCH