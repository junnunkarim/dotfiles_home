widget = {
    plugin = 'timer',
    cb = function()
        return {
            string.format(os.date("^c#1a1710^^b#a45f36^  ^b#1a1710^^c#a45f36^ %I:%M %p ")), -- time
						string.format(os.date("^c#1a1710^^b#87592d^  ^c#87592d^^b#1a1710^ %a, %d %b ")), --date
        }
    end,
}
