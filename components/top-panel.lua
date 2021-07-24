local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
local beautiful = require("beautiful")

local top_panel = {}

top_panel.create = function(s)
    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s, height = beautiful.top_panel_height})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            require("widgets.tag-list").create(s)
        },
        {
            -- Middle widget
            layout = wibox.layout.fixed.horizontal,
            require("widgets.task-list").create(s)
        },
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            wibox.widget.textclock(),
            require("widgets.layoutbox").create(s)
        }
    }
end

return top_panel
