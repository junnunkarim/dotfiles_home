--[[ /proc/net/dev looks like this:

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
docker0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
wlp2s0: 39893402   38711    0    0    0     0          0         0  3676924   27205    0    0    0     0       0          0
    lo:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
--]]

local line_pattern = '^%s*(%S+):' .. ('%s+(%d+)' .. ('%s+%d+'):rep(7)):rep(2) .. '%s*$'
local last_recv, last_sent = {}, {}

local PERIOD = 3

local function get_block(line)
    local iface, recv, sent = line:match(line_pattern)
    assert(iface and recv and sent)

    -- Alternatively, you can filter out unneeded interfaces here, e.g.
    --   if iface ~= 'wlp2s0' then return nil end
    if iface == 'lo' then return nil end

    recv, sent = tonumber(recv), tonumber(sent)
    local prev_recv, prev_sent = last_recv[iface], last_sent[iface]
    local res = nil
    if prev_recv and prev_sent then
        local delta_recv = recv - prev_recv
        local delta_sent = sent - prev_sent
        if (delta_recv >= 0 and delta_sent >= 0) and (recv > 0 and sent > 0) then
            res = string.format('[%s %.0fk↓ %.0fk↑]',
                iface,
                delta_recv / PERIOD / 1000,
                delta_sent / PERIOD / 1000
            )
        end
    end
    last_recv[iface] = recv
    last_sent[iface] = sent
    return res
end

widget = {
    plugin = 'timer',
    opts = {period = PERIOD},
    cb = function()
        local res = {}
        local f = assert(io.open('/proc/net/dev', 'r'))
        for line in f:lines() do
            if not line:find('|') then -- skip the "header" lines
                table.insert(res, get_block(line))
            end
        end
        f:close()
        return res
    end
}
