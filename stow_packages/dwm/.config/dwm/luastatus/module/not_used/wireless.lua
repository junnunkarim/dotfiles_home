local MIN_DBM, MAX_DBM = -90, -20
local NGAUGE = 5
local COLOR_DIM = '#709080'

local function round(x)
    return math.floor(x + 0.5)
end

local function make_wifi_gauge(dbm)
    if dbm < MIN_DBM then dbm = MIN_DBM end
    if dbm > MAX_DBM then dbm = MAX_DBM end
    local nbright = round(NGAUGE * (1 - 0.7 * (MAX_DBM - dbm) / (MAX_DBM - MIN_DBM)))
    return ('●'):rep(nbright) .. ('○'):rep(NGAUGE - nbright)
end

widget = {
    plugin = 'network-linux',
    opts = {
        wireless = true,
        timeout = 10,
    },
    cb = function(t)
        if not t then
            return nil
        end
        local r = {}
        for iface, params in pairs(t) do
            if params.wireless then
                if params.wireless.ssid then
                    r[#r + 1] = params.wireless.ssid
                end
                if params.wireless.signal_dbm then
                    r[#r + 1] = make_wifi_gauge(params.wireless.signal_dbm)
                end
            elseif iface ~= 'lo' and (params.ipv4 or params.ipv6) then
                r[#r + 1] = string.format('[%s]', iface)
            end
        end
        return r
    end,
}
