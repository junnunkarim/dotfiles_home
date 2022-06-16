-- foreground
fg_black0 = "^c#282a36^";
fg_black1 = "^c#44475a^";
fg_white = "^c#f8f8f2^";
fg_black2 = "^c#6272a4^";
fg_cyan = "^c#8be9fd^";
fg_green = "^c#50fa7b^";
fg_orange = "^c#ffb86c^";
fg_pink = "^c#ff79c6^";
fg_purple = "^c#bd93f9^";
fg_red = "^c#ff5555^";
fg_yellow = "^c#f1fa8c^";

-- background
bg_black0 = "^b#282a36^";
bg_black1 = "^b#44475a^";
bg_white = "^b#f8f8f2^";
bg_black2 = "^b#6272a4^";
bg_cyan = "^b#8be9fd^";
bg_green = "^b#50fa7b^";
bg_orange = "^b#ffb86c^";
bg_pink = "^b#ff79c6^";
bg_purple = "^b#bd93f9^";
bg_red = "^b#ff5555^";
bg_yellow = "^b#f1fa8c^";


local color =
{
	-- set colors to modules
	sep = bg_black0 .. fg_black0 .. '|'; -- separator

	date_ic_fg = fg_black0;
	date_ic_bg = bg_purple;
	date_fg 	 = fg_purple;
	date_bg    = bg_black0;

	time_ic_fg = fg_black0;
	time_ic_bg = bg_red;
	time_fg    = fg_red;
	time_bg    = bg_black0;

	wifi_ic_fg = fg_black0;
	wifi_ic_bg = bg_orange;
	wifi_fg    = fg_orange;
	wifi_bg    = bg_black0;

	btt_ic_fg  = fg_black0; -- battery
	btt_ic_bg  = bg_cyan;
	btt_fg     = fg_cyan;
	btt_bg     = bg_black0;
	
	vol_ic_fg  = fg_black0; -- volume
	vol_ic_bg  = bg_yellow;
	vol_fg     = fg_yellow;
	vol_bg     = bg_black0;

	brgn_ic_fg = fg_black0; -- brightness
	brgn_ic_bg = bg_pink;
	brgn_fg    = fg_pink;
	brgn_bg    = bg_black0;
}

return color
