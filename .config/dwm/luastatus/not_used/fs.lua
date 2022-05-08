widget = {
    plugin = 'fs',
    opts = {
        paths = {'/', '/home'},
    },
    cb = function(t)
        local res = {}
        for k, v in pairs(t) do
            table.insert(res, string.format('%s %.0f%%', k,
                (1 - v.avail / v.total) * 100))
        end
        return res
    end,
}
