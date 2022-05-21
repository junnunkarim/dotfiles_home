-- you need to install 'luasec' module (e.g. with luarocks)
-- you can look up all available flags here: https://github.com/chubin/wttr.in#one-line-output

local https = require('ssl.https')
local ltn12 = require('ltn12')

-- All the arguments except for 'url' may be absent or nil; default method is GET.
-- Returns: code (integer), body (string), headers (table), status (string).
function request(url, headers, method, body)
    local out_body = {}
    local is_ok, code_or_errmsg, out_headers, status = https.request(
        {
            url = url,
            sink = ltn12.sink.table(out_body),
            redirect = false,
            cafile = '/etc/ssl/certs/ca-certificates.crt',
            verify = 'peer',
            method = method,
            headers = headers,
        },
        body)
    assert(is_ok, code_or_errmsg)
    return code_or_errmsg, table.concat(out_body), out_headers, status
end

-- Arguments are the same to those of 'request'.
-- Returns: body (string), headers (table).
function request_check_code(...)
    local code, body, headers, status = request(...)
    assert(code == 200, string.format('HTTP %s %s', code, status))
    return body, headers
end

function urlencode(s)
    return string.gsub(s, '[^-_.~a-zA-Z0-9]', function(c)
        return string.format('%%%02X', string.byte(c))
    end)
end

local BASE_URL = 'wttr.in'
local LANG = 'en'
local LOCATION = 'Dhaka'

function get_weather(format)
    -- encoding is needed to allow usage of special use characters
    format = urlencode(format)
    local url = string.format('https://%s.%s/%s?format=%s', LANG, BASE_URL, LOCATION, format)
    local is_ok, body = pcall(request_check_code, url)
    if is_ok then
        return body:gsub("\n", "")
    else
        return nil
    end
end

widget = {
    plugin = 'timer',
    opts = {period = 15 * 60},
    cb = function()
        local text = get_weather('%l: %C %t(%f)')
        if text == nil then
            luastatus.plugin.push_period(60) -- retry in 60 seconds
            text = '......'
        end
        return text
    end,
}
