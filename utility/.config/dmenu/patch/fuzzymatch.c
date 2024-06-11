#include <math.h>

int
compare_distance(const void *a, const void *b)
{
	struct item *da = *(struct item **) a;
	struct item *db = *(struct item **) b;

	if (!db)
		return 1;
	if (!da)
		return -1;

	return da->distance == db->distance ? 0 : da->distance < db->distance ? -1 : 1;
}

void
fuzzymatch(void)
{
	/* bang - we have so much memory */
	struct item *it;
	struct item **fuzzymatches = NULL;
	char c;
	int number_of_matches = 0, i, pidx, sidx, eidx;
	int text_len = strlen(text), itext_len;
	#if HIGHPRIORITY_PATCH
	struct item *lhpprefix, *hpprefixend;
	lhpprefix = hpprefixend = NULL;
	#endif // HIGHPRIORITY_PATCH
	matches = matchend = NULL;

	/* walk through all items */
	for (it = items; it && it->text; it++) {
		if (text_len) {
			itext_len = strlen(it->text);
			pidx = 0; /* pointer */
			sidx = eidx = -1; /* start of match, end of match */
			/* walk through item text */
			for (i = 0; i < itext_len && (c = it->text[i]); i++) {
				/* fuzzy match pattern */
				if (!fstrncmp(&text[pidx], &c, 1)) {
					if (sidx == -1)
						sidx = i;
					pidx++;
					if (pidx == text_len) {
						eidx = i;
						break;
					}
				}
			}
			/* build list of matches */
			if (eidx != -1) {
				/* compute distance */
				/* add penalty if match starts late (log(sidx+2))
				 * add penalty for long a match without many matching characters */
				it->distance = log(sidx + 2) + (double)(eidx - sidx - text_len);
				/* fprintf(stderr, "distance %s %f\n", it->text, it->distance); */
				appenditem(it, &matches, &matchend);
				number_of_matches++;
			}
		} else {
			appenditem(it, &matches, &matchend);
		}
	}

	if (number_of_matches) {
		/* initialize array with matches */
		if (!(fuzzymatches = realloc(fuzzymatches, number_of_matches * sizeof(struct item*))))
			die("cannot realloc %u bytes:", number_of_matches * sizeof(struct item*));
		for (i = 0, it = matches; it && i < number_of_matches; i++, it = it->right) {
			fuzzymatches[i] = it;
		}

		#if NO_SORT_PATCH
		if (sortmatches)
		#endif // NO_SORT_PATCH
		/* sort matches according to distance */
		qsort(fuzzymatches, number_of_matches, sizeof(struct item*), compare_distance);
		/* rebuild list of matches */
		matches = matchend = NULL;
		for (i = 0, it = fuzzymatches[i];  i < number_of_matches && it && \
				it->text; i++, it = fuzzymatches[i]) {
			#if HIGHPRIORITY_PATCH
			#if NO_SORT_PATCH
			if (sortmatches && it->hp)
			#else
			if (it->hp)
			#endif // NO_SORT_PATCH
				appenditem(it, &lhpprefix, &hpprefixend);
			else
				appenditem(it, &matches, &matchend);
			#else
			appenditem(it, &matches, &matchend);
			#endif // HIGHPRIORITY_PATCH
		}
		free(fuzzymatches);
	}
	#if HIGHPRIORITY_PATCH
	if (lhpprefix) {
		hpprefixend->right = matches;
		matches = lhpprefix;
	}
	#endif // HIGHPRIORITY_PATCH
	curr = sel = matches;

	#if INSTANT_PATCH
	if (instant && matches && matches==matchend) {
		puts(matches->text);
		cleanup();
		exit(0);
	}
	#endif // INSTANT_PATCH

	calcoffsets();
}