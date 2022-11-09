-- foreground
fg_pn1 			= "^c#2e3440^";
fg_pn2 			= "^c#3b4252^";
fg_pn3 			= "^c#434c5e^";
fg_pn4 			= "^c#4c566a^";
fg_ss1 			= "^c#d8dee9^";
fg_ss2 			= "^c#e5e9f0^";
fg_ss3 			= "^c#eceff4^";
fg_frost1 	= "^c#8fbcbb^";
fg_frost2 	= "^c#88c0d0^";
fg_frost3 	= "^c#81a1c1^";
fg_frost4 	= "^c#5e81ac^";
fg_aurora1 	= "^c#bf616a^";
fg_aurora2 	= "^c#d08770^";
fg_aurora3 	= "^c#ebcb8b^";
fg_aurora4 	= "^c#a3be8c^";
fg_aurora5 	= "^c#b48ead^";

-- background
bg_pn1 			= "^b#2e3440^";
bg_pn2 			= "^b#3b4252^";
bg_pn3 			= "^b#434c5e^";
bg_pn4 			= "^b#4c566a^";
bg_ss1 			= "^b#d8dee9^";
bg_ss2 			= "^b#e5e9f0^";
bg_ss3 			= "^b#eceff4^";
bg_frost1 	= "^b#8fbcbb^";
bg_frost2 	= "^b#88c0d0^";
bg_frost3 	= "^b#81a1c1^";
bg_frost4 	= "^b#5e81ac^";
bg_aurora1 	= "^b#bf616a^";
bg_aurora2 	= "^b#d08770^";
bg_aurora3 	= "^b#ebcb8b^";
bg_aurora4 	= "^b#a3be8c^";
bg_aurora5 	= "^b#b48ead^";


local color =
{
	-- set colors to modules
	sep = bg_pn1 .. fg_pn1 .. '|'; -- separator

	date_ic_fg 	= fg_pn1;
	date_ic_bg 	= bg_frost4;
	date_fg 		= fg_pn1;
	date_bg 		= bg_frost3;

	time_ic_fg 	= fg_pn1;
	time_ic_bg 	= bg_aurora4;
	time_fg 		= fg_aurora4;
	time_bg 		= bg_pn1;

	wifi_ic_fg 	= fg_pn1;
	wifi_ic_bg 	= bg_aurora3;
	wifi_fg 		= fg_aurora3;
	wifi_bg 		= bg_pn1;

	btt_ic_fg 	= fg_pn1; -- battery
	btt_ic_bg 	= bg_aurora2;
	btt_fg 			= fg_aurora2;
	btt_bg 			= bg_pn1;
	
	vol_ic_fg 	= fg_pn1; -- volume
	vol_ic_bg 	= bg_aurora1;
	vol_fg 			= fg_aurora1;
	vol_bg 			= bg_pn1;

	brgn_ic_fg 	= fg_pn1; -- brightness
	brgn_ic_bg 	= bg_aurora5;
	brgn_fg 		= fg_aurora5;
	brgn_bg 		= bg_pn1;
}

return color
