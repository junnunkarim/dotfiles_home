-- foreground
fg_black = "^c#262643^";
fg_black0 = "^c#171728^";
fg_white = "^c#F9F3ED^";
fg_white0 = "^c#F0D1A9^";
fg_purple1 = "^c#C49DA3^";
fg_purple2 = "^c#896C9A^";
fg_purple3 = "^c#484C7D^";

-- background
bg_black = "^b#262643^";
bg_black0 = "^b#171728^";
bg_white = "^b#F9F3ED^";
bg_white0 = "^b#F0D1A9^";
bg_purple1 = "^b#C49DA3^";
bg_purple2 = "^b#896C9A^";
bg_purple3 = "^b#484C7D^";


local color =
{
	-- set colors to modules
	sep = bg_black .. fg_black .. '|'; -- separator

	date_ic_fg = fg_white;
	date_ic_bg = bg_purple3;
	date_fg = fg_white;
	date_bg = bg_black;

	time_ic_fg = fg_white;
	time_ic_bg = bg_purple2;
	time_fg = fg_white;
	time_bg = bg_black;

	wifi_ic_fg = fg_white;
	wifi_ic_bg = bg_purple1;
	wifi_fg = fg_white;
	wifi_bg = bg_black;

	btt_ic_fg = fg_black; -- battery
	btt_ic_bg = bg_white0;
	btt_fg = fg_white;
	btt_bg = bg_black;
	
	vol_ic_fg = fg_white; -- volume
	vol_ic_bg = bg_purple3;
	vol_fg = fg_white;
	vol_bg = bg_black;

	brgn_ic_fg = fg_white; -- brightness
	brgn_ic_bg = bg_purple2;
	brgn_fg = fg_white;
	brgn_bg = bg_black;
}

return color
