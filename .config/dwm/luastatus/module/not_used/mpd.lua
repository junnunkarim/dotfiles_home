-- you need to install 'utf8' module (e.g. with luarocks) if using Lua <=5.2.
utf8 = require 'utf8'

titlewidth = 40

widget = {
    plugin = 'mpd',
    cb = function(t)
        if t.what == 'update' then
            local title
            if t.song.Title then
                title = t.song.Title
                if t.song.Artist then
                    title = t.song.Artist .. ': ' .. title
                end
            else
                title = t.song.file or ''
            end
            title = (utf8.len(title) <= titlewidth)
                and title
                or utf8.sub(title, 1, titlewidth - 1) .. '…'

            return string.format('%s %s',
                ({play = '▶', pause = '‖', stop = '■'})[t.status.state],
                title
            )
        else
            -- 'connecting' or 'error'
            return t.what
        end
    end
}
