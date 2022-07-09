-- foreground
fg_rosewater = "^c#f4dbd6^";
fg_flamingo = "^c#f0c6c6^";
fg_pink = "^c#f5bde6^";
fg_mauve = "^c#c6a0f6^";
fg_red = "^c#ed8796^";
fg_maroon = "^c#ee99a0^";
fg_peach = "^c#f5a97f^";
fg_yellow = "^c#eed49f^";
fg_green = "^c#a6da95^";
fg_teal = "^c#8bd5ca^";
fg_sky = "^c#91d7e3^";
fg_sapphire = "^c#7dc4e4^";
fg_blue = "^c#8aadf4^";
fg_lavender = "^c#b7bdf8^";
fg_text = "^c#cad3f5^";
fg_subtext1 = "^c#b8c0e0^";
fg_overlay1 = "^c#8087a2^";
fg_surface1 = "^c#494d64^";
fg_base = "^c#24273a^";
fg_mantle = "^c#1e2030^";
fg_crust = "^c#181926^";

-- background
bg_rosewater = "^b#f4dbd6^";
bg_flamingo = "^b#f0c6c6^";
bg_pink = "^b#f5bde6^";
bg_mauve = "^b#c6a0f6^";
bg_red = "^b#ed8796^";
bg_maroon = "^b#ee99a0^";
bg_peach = "^b#f5a97f^";
bg_yellow = "^b#eed49f^";
bg_green = "^b#a6da95^";
bg_teal = "^b#8bd5ca^";
bg_sky = "^b#91d7e3^";
bg_sapphire = "^b#7dc4e4^";
bg_blue = "^b#8aadf4^";
bg_lavender = "^b#b7bdf8^";
bg_text = "^b#cad3f5^";
bg_subtext1 = "^b#b8c0e0^";
bg_overlay1 = "^b#8087a2^";
bg_surface1 = "^b#494d64^";
bg_base = "^b#24273a^";
bg_mantle = "^b#1e2030^";
bg_crust = "^b#181926^";


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
