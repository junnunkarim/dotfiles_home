static void
#if EMOJI_HIGHLIGHT_PATCH
drawhighlights(struct item *item, char *output, int x, int y, int maxw)
#else
drawhighlights(struct item *item, int x, int y, int maxw)
#endif // EMOJI_HIGHLIGHT_PATCH
{
	int i, indent;
	char *highlight;
	char c;

	#if EMOJI_HIGHLIGHT_PATCH
	char *itemtext = output;
	#elif TSV_PATCH
	char *itemtext = item->stext;
	#else
	char *itemtext = item->text;
	#endif // TSV_PATCH

	if (!(strlen(itemtext) && strlen(text)))
		return;

	drw_setscheme(drw, scheme[item == sel
	                   ? SchemeSelHighlight
	                   : SchemeNormHighlight]);
	for (i = 0, highlight = itemtext; *highlight && text[i];) {
		#if FUZZYMATCH_PATCH
		if (!fstrncmp(&(*highlight), &text[i], 1))
		#else
		if (*highlight == text[i])
		#endif // FUZZYMATCH_PATCH
		{
			/* get indentation */
			c = *highlight;
			*highlight = '\0';
			indent = TEXTW(itemtext);
			*highlight = c;

			/* highlight character */
			c = highlight[1];
			highlight[1] = '\0';
			drw_text(
				drw,
				x + indent - (lrpad / 2),
				y,
				MIN(maxw - indent, TEXTW(highlight) - lrpad),
				bh, 0, highlight, 0
				#if PANGO_PATCH
				, True
				#endif // PANGO_PATCH
			);
			highlight[1] = c;
			i++;
		}
		highlight++;
	}
}
