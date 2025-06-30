-- Trivial but somewhat useful widget showing if the Tor daemon is running.

widget = {
    plugin = 'timer',
    opts = {period = 5},
    cb = function()
        local f = io.open('/var/run/tor/tor.pid', 'r')
        if f then
            f:close()
            return '[TOR]'
        end
    end,
}
