-- foreground
fg_rosewater = "^c#f2d5cf^";
fg_flamingo = "^c#eebebe^";
fg_pink = "^c#f4b8e4^";
fg_mauve = "^c#ca9ee6^";
fg_red = "^c#e78284^";
fg_maroon = "^c#ea999c^";
fg_peach = "^c#ef9f76^";
fg_yellow = "^c#e5c890^";
fg_green = "^c#a6d189^";
fg_teal = "^c#81c8be^";
fg_sky = "^c#99d1db^";
fg_sapphire = "^c#85c1dc^";
fg_blue = "^c#8caaee^";
fg_lavender = "^c#babbf1^";
fg_text = "^c#c6d0f5^";
fg_subtext1 = "^c#b5bfe2^";
fg_overlay1 = "^c#838ba7^";
fg_surface1 = "^c#51576d^";
fg_base = "^c#303446^";
fg_mantle = "^c#292c3c^";
fg_crust = "^c#232634^";

-- background
bg_rosewater = "^b#f2d5cf^";
bg_flamingo = "^b#eebebe^";
bg_pink = "^b#f4b8e4^";
bg_mauve = "^b#ca9ee6^";
bg_red = "^b#e78284^";
bg_maroon = "^b#ea999c^";
bg_peach = "^b#ef9f76^";
bg_yellow = "^b#e5c890^";
bg_green = "^b#a6d189^";
bg_teal = "^b#81c8be^";
bg_sky = "^b#99d1db^";
bg_sapphire = "^b#85c1dc^";
bg_blue = "^b#8caaee^";
bg_lavender = "^b#babbf1^";
bg_text = "^b#c6d0f5^";
bg_subtext1 = "^b#b5bfe2^";
bg_overlay1 = "^b#838ba7^";
bg_surface1 = "^b#51576d^";
bg_base = "^b#303446^";
bg_mantle = "^b#292c3c^";
bg_crust = "^b#232634^";


local color =
{
	-- set colors to modules
	sep = bg_crust .. fg_mantle .. '|'; -- separator

	date_ic_fg = fg_crust;
	date_ic_bg = bg_red;
	date_fg = fg_red;
	date_bg = bg_crust;

	time_ic_fg = fg_crust;
	time_ic_bg = bg_pink;
	time_fg = fg_pink;
	time_bg = bg_crust;

	wifi_ic_fg = fg_crust;
	wifi_ic_bg = bg_blue;
	wifi_fg = fg_blue;
	wifi_bg = bg_crust;

	btt_ic_fg = fg_crust; -- battery
	btt_ic_bg = bg_peach;
	btt_fg = fg_peach;
	btt_bg = bg_crust;
	
	vol_ic_fg = fg_mauve; -- volume
	vol_ic_bg = bg_crust;
	vol_fg = fg_mauve;
	vol_bg = bg_crust;

	brgn_ic_fg = fg_text; -- brightness
	brgn_ic_bg = bg_crust;
	brgn_fg = fg_text;
	brgn_bg = bg_crust;
}

return color
