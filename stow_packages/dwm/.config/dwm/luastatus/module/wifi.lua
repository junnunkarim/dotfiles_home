-- local MIN_DBM, MAX_DBM = -90, -20
-- local NGAUGE = 5
-- local COLOR_DIM = "#709080"
--
-- local function round(x)
-- 	return math.floor(x + 0.5)
-- end
--
-- local function make_wifi_gauge(signal_dbm)
-- 	if signal_dbm < MIN_DBM then
-- 		signal_dbm = MIN_DBM
-- 	end
-- 	if signal_dbm > MAX_DBM then
-- 		signal_dbm = MAX_DBM
-- 	end
-- 	local nbright = round(NGAUGE * (1 - 0.7 * (MAX_DBM - signal_dbm) / (MAX_DBM - MIN_DBM)))
-- 	return ("●"):rep(nbright) .. ("○"):rep(NGAUGE - nbright)
-- end

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

widget = {
	plugin = "network-linux",
	opts = {
		wireless = true,
		timeout = 10,
	},

	cb = function(t)
		--[[
    -- sample structure of table t
    wlp1s0:
      wireless:
        frequency: 2437000000
        bitrate: 520
        ssid: something
        signal_dbm: -36
      ipv6:
      ipv4:
    virbr0:
      ipv4:
    lo:
      ipv4:
      ipv6:
    enp2s0:
    ]]
		--

		if not t then
			return nil
		end

		for connection_type, params in pairs(t) do
			if params.wireless then
				if params.wireless.ssid then
					local wifi = params.wireless.ssid

					-- truncate extra
					if #wifi > 7 then
						wifi = string.sub(wifi, 1, 7) .. "..."
					end

					wifi = string.format(
						color.sep
							.. color.wifi_ic_fg
							.. color.wifi_ic_bg
							.. "  "
							.. color.wifi_fg
							.. color.wifi_bg
							.. " %s ",
						wifi
					)

					return wifi

					-- if params.wireless.signal_dbm then
					-- 	return {
					-- 		wifi,
					-- 		make_wifi_gauge(params.wireless.signal_dbm),
					-- 	}
					-- else
					-- 	return wifi
					-- end
				end
			end
		end

		return nil
	end,
}
