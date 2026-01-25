static void
draw_key_feedback(Display *dpy, struct lock **locks, int screen)
{
	XGCValues gr_values;

	Window win = locks[screen]->win;
	Window root_win;

	gr_values.foreground = locks[screen]->colors[BLOCKS];
	GC gc = XCreateGC(dpy, win, GCForeground, &gr_values);

	int width = blocks_width, height = blocks_height;
	if (blocks_height == 0 || blocks_width == 0) {
		int _x, _y;
		unsigned int screen_width, screen_height, _b, _d;
		XGetGeometry(dpy, win, &root_win, &_x, &_y, &screen_width, &screen_height, &_b, &_d);
		width = blocks_width ? blocks_width : screen_width;
		height = blocks_height ? blocks_height : screen_height;
	}

	unsigned int block_width = width / blocks_count;
	unsigned int position = rand() % blocks_count;

	XClearWindow(dpy, win);
	XFillRectangle(dpy, win, gc, blocks_x + position*block_width, blocks_y, width, height);

	XFreeGC(dpy, gc);
}