-- foreground
fg_black = "^c#141b1e^";
fg_ligtherblack = "^c#232a2d^";
fg_red = "^c#e57474^";
fg_green = "^c#8ccf7e^";
fg_yellow = "^c#e5c76b^";
fg_blue = "^c#67b0e8^";
fg_magenta = "^c#c47fd5^";
fg_cyan = "^c#6cbfbf^";
fg_gray = "^c#b3b9b8^";
fg_white = "^c#dadada^";

-- background
bg_black = "^b#141b1e^";
bg_ligtherblack = "^b#232a2d^";
bg_red = "^b#e57474^";
bg_green = "^b#8ccf7e^";
bg_yellow = "^b#e5c76b^";
bg_blue = "^b#67b0e8^";
bg_magenta = "^b#c47fd5^";
bg_cyan = "^b#6cbfbf^";
bg_gray = "^b#b3b9b8^";
bg_white = "^b#dadada^";

local color =
{
	-- set colors to modules
	sep = bg_black .. fg_black .. '|'; -- separator

	date_ic_fg = fg_black;
	date_ic_bg = bg_green;
	date_fg = fg_black;
	date_bg = bg_green;

	time_ic_fg = fg_black;
	time_ic_bg = bg_red;
	time_fg = fg_black;
	time_bg = bg_red;

	wifi_ic_fg = fg_black;
	wifi_ic_bg = bg_yellow;
	wifi_fg = fg_black;
	wifi_bg = bg_yellow;

	btt_ic_fg = fg_black; -- battery
	btt_ic_bg = bg_blue;
	btt_fg = fg_black;
	btt_bg = bg_blue;
	
	vol_ic_fg = fg_black; -- volume
	vol_ic_bg = bg_magenta;
	vol_fg = fg_black;
	vol_bg = bg_magenta;

	brgn_ic_fg = fg_black; -- brightness
	brgn_ic_bg = bg_cyan;
	brgn_fg = fg_black;
	brgn_bg = bg_cyan;
}

return color
