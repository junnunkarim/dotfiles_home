local beautiful = require("beautiful")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

require("visual.colorschemes")
require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")


local colors = GRUVBOX
local theme = {
    font_name            = "Iosevka Nerd Font Mono",
    font                 = "Iosevka Nerd Font Mono 10",
    -- font = "Li Alinur Banglaborno Unicode 12",
    -- font = "CozetteVector 10",
    taglist_font         = "Iosevka Nerd Font Mono 20",
    tasklist_font        = "Iosevka Nerd Font Mono 20",

    useless_gap          = dpi(5),
    border_width         = dpi(2),
    border_color_normal  = titlebar_colors.border,
    border_color_active  = titlebar_colors.border_focus,
    --border_color_marked = "#91231c",

    -- TODO: need to implement more robust and modular solution
    -- breaks hotkeys_popup widget if the values aren't set
    bg_normal            = TRANSPARENT,
    bg_focus             = taglist_colors.bg_focus,
    bg_urgent            = taglist_colors.bg_urgent,
    bg_minimize          = tasklist_colors.bg_minimize,
    bg_systray           = tray_colors.fg,

    fr_normal            = taglist_colors.fg,
    fg_focus             = taglist_colors.fg_focus,
    fg_urgent            = taglist_colors.fg_urgent,
    fg_minimize          = tasklist_colors.fg_minimize,

    taglist_spacing      = 3,
    systray_icon_spacing = 5,

    -- There are other variable sets
    -- overriding the default one when
    -- defined, the sets are:
    -- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
    -- tasklist_[bg|fg]_[focus|urgent]
    -- titlebar_[bg|fg]_[normal|focus]
    -- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
    -- prompt_[fg|bg|fg_cursor|bg_cursor|font]
    -- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
    -- Example:
    --taglist_bg_focus = "#ff0000"

    --tasklist_disable_icon = true


    -- Variables set for theming notifications:
    -- notification_font
    -- notification_[bg|fg]
    -- notification_[width|height|margin]
    -- notification_[border_color|border_width|shape|opacity]

    -- Variables set for theming the menu:
    -- menu_[bg|fg]_[normal|focus]
    -- menu_[border_color|border_width]
    menu_submenu_icon = themes_path .. "default/submenu.png",
    menu_height       = dpi(20),
    menu_width        = dpi(200),

    -- You can add as many variables as
    -- you wish and access them by using
    -- beautiful.variable in your rc.lua
    --bg_widget = "#cc0000"

    --[[
    -- Define the image to load
    titlebar_close_button_normal = themes_path .."default/titlebar/close_normal.png"
    titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

    titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
    titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

    titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
    titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
    titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
    titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

    titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
    titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
    titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
    titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

    titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
    titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
    titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
    titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

    titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
    titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
    titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
    titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

    wallpaper = themes_path.."default/background.png"
    ]] --

    -- You can use your own layout icons like this:
    layout_fairh                     = themes_path .. "default/layouts/fairhw.png",
    layout_fairv                     = themes_path .. "default/layouts/fairvw.png",
    layout_floating                  = themes_path .. "default/layouts/floatingw.png",
    layout_magnifier                 = themes_path .. "default/layouts/magnifierw.png",
    layout_max                       = themes_path .. "default/layouts/maxw.png",
    layout_fullscreen                = themes_path .. "default/layouts/fullscreenw.png",
    layout_tilebottom                = themes_path .. "default/layouts/tilebottomw.png",
    layout_tileleft                  = themes_path .. "default/layouts/tileleftw.png",
    layout_tile                      = themes_path .. "default/layouts/tilew.png",
    layout_tiletop                   = themes_path .. "default/layouts/tiletopw.png",
    layout_spiral                    = themes_path .. "default/layouts/spiralw.png",
    layout_dwindle                   = themes_path .. "default/layouts/dwindlew.png",
    layout_cornernw                  = themes_path .. "default/layouts/cornernww.png",
    layout_cornerne                  = themes_path .. "default/layouts/cornernew.png",
    layout_cornersw                  = themes_path .. "default/layouts/cornersww.png",
    layout_cornerse                  = themes_path .. "default/layouts/cornersew.png",

    -- Generate Awesome icon:
    --awesome_icon = theme_assets.awesome_icon(
    --    menu_height, theme.bg_focus, theme.fg_focus
    --)

    -- Define the icon for application icons. If not set then the icons
    -- from /usr/share/icons and /usr/share/icons/hicolor will be used.
    --icon_theme = os.getenv("HOME") .. "/.icons/Papirus/"
    icon_theme                       = "Papirus",

    tag_preview_widget_border_radius = 0,            -- Border radius of the widget (With AA)
    tag_preview_client_border_radius = 0,            -- Border radius of each client in the widget (With AA)
    tag_preview_client_opacity       = 1.0,          -- Opacity of each client
    tag_preview_client_bg            = "#000000",    -- The bg color of each client
    tag_preview_client_border_color  = colors.blue2, -- The border color of each client
    tag_preview_client_border_width  = 0,            -- The border width of each client
    tag_preview_widget_bg            = "#000000",    -- The bg color of the widget
    tag_preview_widget_border_color  = colors.blue2, -- The border color of the widget
    tag_preview_widget_border_width  = 3,            -- The border width of the widget
    tag_preview_widget_margin        = 0,            -- The margin of the widget
}


-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
