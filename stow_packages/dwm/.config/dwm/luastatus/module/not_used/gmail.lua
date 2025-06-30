--[[
-- Expects 'credentials.lua' to be present in the current directory; it may contain, e.g.,
--     return {
--         gmail = {
--             login = 'john.smith',
--             password = 'qwerty'
--         }
--     }
--]]
credentials = require 'credentials'

widget = luastatus.require_plugin('imap').widget{
    verbose = false,
    host = 'imap.gmail.com',
    port = 993,
    mailbox = 'Inbox',
    use_ssl = true,
    timeout = 2 * 60,
    handshake_timeout = 10,
    login = credentials.gmail.login,
    password = credentials.gmail.password,
    error_sleep_period = 60,
    cb = function(unseen)
        if unseen == nil or unseen == 0 then
            return nil
        else
            return string.format('[%d unseen]', unseen)
        end
    end,
}
