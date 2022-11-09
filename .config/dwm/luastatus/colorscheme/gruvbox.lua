-- foreground
fg_black = "^c#282828^";
fg_black0 = "^c#1d2021^";
fg_white = "^c#ebdbb2^";
fg_white0 = "^c#fbf1c7^";
fg_gray1 = "^c#a89984^";
fg_gray2 = "^c#928374^";
fg_red1 = "^c#cc241d^";
fg_red2 = "^c#fb4934^";
fg_green1 = "^c#98971a^";
fg_green2 = "^c#b8bb26^";
fg_yellow1 = "^c#d79921^";
fg_yellow2 = "^c#fabd2f^";
fg_blue1 = "^c#458588^";
fg_blue2 = "^c#83a598^";
fg_purple1 = "^c#b16286^";
fg_purple2 = "^c#d3869b^";
fg_aqua1 = "^c#689d6a^";
fg_aqua2 = "^c#8ec07c^";
fg_orange1 = "^c#d65d0e^";
fg_orange2 = "^c#fe8019^";

-- background
bg_black = "^b#282828^";
bg_black0 = "^b#1d2021^";
bg_white = "^b#ebdbb2^";
bg_white0 = "^b#fbf1c7^";
bg_gray1 = "^b#a89984^";
bg_gray2 = "^b#928374^";
bg_red1 = "^b#cc241d^";
bg_red2 = "^b#fb4934^";
bg_green1 = "^b#98971a^";
bg_green2 = "^b#b8bb26^";
bg_yellow1 = "^b#d79921^";
bg_yellow2 = "^b#fabd2f^";
bg_blue1 = "^b#458588^";
bg_blue2 = "^b#83a598^";
bg_purple1 = "^b#b16286^";
bg_purple2 = "^b#d3869b^";
bg_aqua1 = "^b#689d6a^";
bg_aqua2 = "^b#8ec07c^";
bg_orange1 = "^b#d65d0e^";
bg_orange2 = "^b#fe8019^";


local color =
{
	-- set colors to modules
	sep = bg_black .. fg_black .. '|'; -- separator

	date_ic_fg = fg_black;
	date_ic_bg = bg_orange1;
	date_fg = fg_black;
	date_bg = bg_orange2;

	time_ic_fg = fg_black;
	time_ic_bg = bg_yellow1;
	time_fg = fg_black;
	time_bg = bg_yellow2;

	wifi_ic_fg = fg_black;
	wifi_ic_bg = bg_green1;
	wifi_fg = fg_black;
	wifi_bg = bg_green2;

	btt_ic_fg = fg_black; -- battery
	btt_ic_bg = bg_blue1;
	btt_fg = fg_black;
	btt_bg = bg_blue2;
	
	vol_ic_fg = fg_black; -- volume
	vol_ic_bg = bg_purple1;
	vol_fg = fg_black;
	vol_bg = bg_purple2;

	brgn_ic_fg = fg_black; -- brightness
	brgn_ic_bg = bg_aqua1;
	brgn_fg = fg_black;
	brgn_bg = bg_aqua2;
}

return color
