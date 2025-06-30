local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local brightness_widget = {}

function brightness_widget.create()
    local widget = wibox.widget {
        text = "Brightness: N/A%",
        widget = wibox.widget.textbox
    }

    local function update_brightness()
        awful.spawn.easy_async_with_shell("brightnessctl g", function(stdout)
            local brightness = tonumber(stdout)
            widget:set_text("Brightness: " .. brightness .. "%")
        end)
    end

    local timeout_duration = 5  -- Adjust the duration (in seconds) as needed

    local function hide_widget()
        widget.visible = false
    end

    local timer = gears.timer {
        timeout = timeout_duration,
        single_shot = true,
        callback = hide_widget
    }

    update_brightness()
    awesome.connect_signal("brightness::update", update_brightness)

    -- Start the timer when the brightness widget becomes visible
    widget:connect_signal("property::visible", function()
        if widget.visible then
            timer:again()
        else
            timer:stop()
        end
    end)

    return widget
end

return brightness_widget
