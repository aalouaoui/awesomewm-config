local gears = require("gears")
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")

local top_panel = {}

top_panel.create = function(s)
    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            require("widgets.taglist").create(s)
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
            require("widgets.layoutbox").create(s),
            wibox.widget.textclock()
        }
    }
end

return top_panel
