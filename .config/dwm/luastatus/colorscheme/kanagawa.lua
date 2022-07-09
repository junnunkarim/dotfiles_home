-- foreground
fg_fujiwhite = "^c#dcd7ba^";
fg_oldwhite = "^c#c8c093^";
fg_sumilnk0 = "^c#16161d^";
fg_sumilnk1 = "^c#1f1f28^";
fg_sumilnk2 = "^c#2a2a37^";
fg_sumilnk3 = "^c#363646^";
fg_sumilnk4 = "^c#54546d^";
fg_waveblue1 = "^c#223249^";
fg_waveblue2 = "^c#2d4f67^";
fg_wintergreen = "^c#2b3328^";
fg_winteryellow = "^c#49443c^";
fg_winterred = "^c#43242b^";
fg_winterblue = "^c#252535^";
fg_autumngreen = "^c#76946a^";
fg_autumnred = "^c#c34043^";
fg_autumnyellow = "^c#dca561^";
fg_samuraired = "^c#e82424^";
fg_roninyellow = "^c#ff9e3b^";
fg_waveaqua1 = "^c#6a9589^";
fg_dragonblue = "^c#658594^";
fg_fujigray = "^c#727169^";
fg_springviolet1 = "^c#938aa9^";
fg_oniviolet = "^c#957fb8^";
fg_crystalblue = "^c#7e9cd8^";
fg_springviolet2 = "^c#9cabca^";
fg_springblue = "^c#7fb4ca^";
fg_lightblue = "^c#a3d4d5^";
fg_waveaqua2 = "^c#7aa89f^";
fg_springgreen = "^c#98bb6c^";
fg_boatyellow1 = "^c#938056^";
fg_boatyellow2 = "^c#c0a36e^";
fg_carpyellow = "^c#e6c384^";
fg_sakurapink = "^c#d27e99^";
fg_wavered = "^c#e46876^";
fg_peachred = "^c#ff5d62^";
fg_surimiorange = "^c#ffa066^";
fg_katanagray = "^c#717c7c^";

-- background
bg_fujiwhite = "^b#dcd7ba^";
bg_oldwhite = "^b#c8c093^";
bg_sumilnk0 = "^b#16161d^";
bg_sumilnk1 = "^b#1f1f28^";
bg_sumilnk2 = "^b#2a2a37^";
bg_sumilnk3 = "^b#363646^";
bg_sumilnk4 = "^b#54546d^";
bg_waveblue1 = "^b#223249^";
bg_waveblue2 = "^b#2d4f67^";
bg_wintergreen = "^b#2b3328^";
bg_winteryellow = "^b#49443c^";
bg_winterred = "^b#43242b^";
bg_winterblue = "^b#252535^";
bg_autumngreen = "^b#76946a^";
bg_autumnred = "^b#c34043^";
bg_autumnyellow = "^b#dca561^";
bg_samuraired = "^b#e82424^";
bg_roninyellow = "^b#ff9e3b^";
bg_waveaqua1 = "^b#6a9589^";
bg_dragonblue = "^b#658594^";
bg_fujigray = "^b#727169^";
bg_springviolet1 = "^b#938aa9^";
bg_oniviolet = "^b#957fb8^";
bg_crystalblue = "^b#7e9cd8^";
bg_springviolet2 = "^b#9cabca^";
bg_springblue = "^b#7fb4ca^";
bg_lightblue = "^b#a3d4d5^";
bg_waveaqua2 = "^b#7aa89f^";
bg_springgreen = "^b#98bb6c^";
bg_boatyellow1 = "^b#938056^";
bg_boatyellow2 = "^b#c0a36e^";
bg_carpyellow = "^b#e6c384^";
bg_sakurapink = "^b#d27e99^";
bg_wavered = "^b#e46876^";
bg_peachred = "^b#ff5d62^";
bg_surimiorange = "^b#ffa066^";
bg_katanagray = "^b#717c7c^";


local color =
{
	-- set colors to modules
	sep = bg_black .. fg_black .. '|'; -- separator

	date_ic_fg = fg_fujiwhite;
	date_ic_bg = bg_sakurapink;
	date_fg = fg_sakurapink;
	date_bg = bg_sumilnk0;

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
