widget = {
    plugin = 'network-linux',
    cb = function(t)
        local r = {}
        for iface, params in pairs(t) do
            local addr = params.ipv6 or params.ipv4
            if addr then
                -- strip out "label" from the interface name
                iface = iface:gsub(':.*', '')
                -- strip out "zone index" from the address
                addr = addr:gsub('%%.*', '')

                if iface ~= 'lo' then
                    r[#r + 1] = string.format('[%s: %s]', iface, addr)
                end
            end
        end
        return r
    end,
}
