#include <Imlib2.h>

Imlib_Image image;

void
render_lock_image(Display *dpy, struct lock *lock, Imlib_Image image)
{
	if (image) {
		lock->bgmap = XCreatePixmap(dpy, lock->root, DisplayWidth(dpy, lock->screen), DisplayHeight(dpy, lock->screen), DefaultDepth(dpy, lock->screen));
		imlib_context_set_image(image);
		imlib_context_set_display(dpy);
		imlib_context_set_visual(DefaultVisual(dpy, lock->screen));
		imlib_context_set_colormap(DefaultColormap(dpy, lock->screen));
		imlib_context_set_drawable(lock->bgmap);
		imlib_render_image_on_drawable(0, 0);
		imlib_free_image();
	}
}

void
create_lock_image(Display *dpy)
{
	/* Create screenshot Image */
	Screen *scr = ScreenOfDisplay(dpy, DefaultScreen(dpy));
	image = imlib_create_image(scr->width,scr->height);
	imlib_context_set_image(image);
	imlib_context_set_display(dpy);
	imlib_context_set_visual(DefaultVisual(dpy,0));
	imlib_context_set_drawable(RootWindow(dpy,XScreenNumberOfScreen(scr)));
	imlib_copy_drawable_to_image(0,0,0,scr->width,scr->height,0,0,1);

	#ifdef BLUR
	/* Blur function */
	imlib_image_blur(blurRadius);
	#endif // BLUR

	#ifdef PIXELATION
	/* Pixelation */
	int width = scr->width;
	int height = scr->height;

	for (int y = 0; y < height; y += pixelSize) {
		for (int x = 0; x < width; x += pixelSize) {
			int red = 0;
			int green = 0;
			int blue = 0;

			Imlib_Color pixel;
			Imlib_Color* pp;
			pp = &pixel;
			for (int j = 0; j < pixelSize && j < height; j++) {
				for (int i = 0; i < pixelSize && i < width; i++) {
					imlib_image_query_pixel(x + i, y + j, pp);
					red += pixel.red;
					green += pixel.green;
					blue += pixel.blue;
				}
			}
			red /= (pixelSize * pixelSize);
			green /= (pixelSize * pixelSize);
			blue /= (pixelSize * pixelSize);
			imlib_context_set_color(red, green, blue, pixel.alpha);
			imlib_image_fill_rectangle(x, y, pixelSize, pixelSize);
			red = 0;
			green = 0;
			blue = 0;
		}
	}
	#endif
}