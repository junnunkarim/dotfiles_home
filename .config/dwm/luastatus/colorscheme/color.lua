fg_base = "^c#191724^";
fg_surface = "^c#1f1d2e^";
fg_overlay = "^c#26233a^";
fg_muted = "^c#6e6a86^";
fg_subtle = "^c#908caa^";
fg_text = "^c#e0def4^";
fg_love = "^c#eb6f92^";
fg_love_1 = "^c#b4637a^";
fg_gold = "^c#f6c177^";
fg_gold_1 = "^c#ea9d34^";
fg_rose = "^c#ebbcba^";
fg_rose_1 = "^c#d7827e^";
fg_foam = "^c#9ccfd8^";
fg_pine = "^c#31748f^";
fg_iris = "^c#c4a7e7^";
fg_iris_1 = "^c#907aa9^";

bg_base = "^b#191724^";
bg_surface = "^b#1f1d2e^";
bg_overlay = "^b#26233a^";
bg_muted = "^b#6e6a86^";
bg_subtle = "^b#908caa^";
bg_text = "^b#e0def4^";
bg_love = "^b#eb6f92^";
bg_love_1 = "^b#b4637a^";
bg_gold = "^b#f6c177^";
bg_gold_1 = "^b#ea9d34^";
bg_rose = "^b#ebbcba^";
bg_rose_1 = "^b#d7827e^";
bg_foam = "^b#9ccfd8^";
bg_pine = "^b#31748f^";
bg_iris = "^b#c4a7e7^";
bg_iris_1 = "^b#907aa9^";

local color =
{
	-- set colors to modules
	sep = bg_base .. fg_base .. '|'; -- separator

	date_ic_fg = fg_base;
	date_ic_bg = bg_rose_1;
	date_fg = fg_base;
	date_bg = bg_rose;

	time_ic_fg = fg_text;
	time_ic_bg = bg_pine;
	time_fg = fg_base;
	time_bg = bg_foam;

	wifi_ic_fg = fg_base;
	wifi_ic_bg = bg_iris_1;
	wifi_fg = fg_base;
	wifi_bg = bg_iris;

	btt_ic_fg = fg_base; -- battery
	btt_ic_bg = bg_love_1;
	btt_fg = fg_base;
	btt_bg = bg_love;

	vol_ic_fg = fg_base; -- volume
	vol_ic_bg = bg_gold;
	vol_fg = fg_base;
	vol_bg = bg_gold_1;

	brgn_ic_fg = fg_base; -- brightness
	brgn_ic_bg = bg_pine;
	brgn_fg = fg_base;
	brgn_bg = bg_foam;
}

return color
