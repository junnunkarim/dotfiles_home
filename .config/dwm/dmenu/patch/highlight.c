static void
#if EMOJI_HIGHLIGHT_PATCH
drawhighlights(struct item *item, char *output, int x, int y, int maxw)
#else
drawhighlights(struct item *item, int x, int y, int maxw)
#endif // EMOJI_HIGHLIGHT_PATCH
{
	char restorechar, tokens[sizeof text], *highlight,  *token;
	int indentx, highlightlen;
	#if EMOJI_HIGHLIGHT_PATCH
	char *itemtext = output;
	#elif TSV_PATCH
	char *itemtext = item->stext;
	#else
	char *itemtext = item->text;
	#endif // TSV_PATCH

	drw_setscheme(drw, scheme[item == sel ? SchemeSelHighlight : SchemeNormHighlight]);
	strcpy(tokens, text);
	for (token = strtok(tokens, " "); token; token = strtok(NULL, " ")) {
		highlight = fstrstr(itemtext, token);
		while (highlight) {
			// Move item str end, calc width for highlight indent, & restore
			highlightlen = highlight - itemtext;
			restorechar = *highlight;
			itemtext[highlightlen] = '\0';
			indentx = TEXTW(itemtext);
			itemtext[highlightlen] = restorechar;

			// Move highlight str end, draw highlight, & restore
			restorechar = highlight[strlen(token)];
			highlight[strlen(token)] = '\0';
			if (indentx - (lrpad / 2) - 1 < maxw)
				drw_text(
					drw,
					x + indentx - (lrpad / 2) - 1,
					y,
					MIN(maxw - indentx, TEXTW(highlight) - lrpad),
					bh, 0, highlight, 0
					#if PANGO_PATCH
					, True
					#endif // PANGO_PATCH
				);
			highlight[strlen(token)] = restorechar;

			if (strlen(highlight) - strlen(token) < strlen(token))
				break;
			highlight = fstrstr(highlight + strlen(token), token);
		}
	}
}