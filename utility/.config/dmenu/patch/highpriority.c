static char **hpitems = NULL;
static int hplength = 0;

static char **
tokenize(char *source, const char *delim, int *llen)
{
	int listlength = 0, list_size = 0;
	char **list = NULL, *token;

	token = strtok(source, delim);
	while (token) {
		if (listlength + 1 >= list_size) {
			if (!(list = realloc(list, (list_size += 8) * sizeof(*list))))
				die("Unable to realloc %zu bytes\n", list_size * sizeof(*list));
		}
		if (!(list[listlength] = strdup(token)))
			die("Unable to strdup %zu bytes\n", strlen(token) + 1);
		token = strtok(NULL, delim);
		listlength++;
	}

	*llen = listlength;
	return list;
}

static int
arrayhas(char **list, int length, char *item) {
	for (int i = 0; i < length; i++) {
		int len1 = strlen(list[i]);
		int len2 = strlen(item);
		if (fstrncmp(list[i], item, len1 > len2 ? len2 : len1) == 0)
			return 1;
	}
	return 0;
}