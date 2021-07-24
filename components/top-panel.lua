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
            awful.widget.taglist {
                screen = s,
                filter = awful.widget.taglist.filter.all,
                buttons = gears.table.join(
                    awful.button(
                        {},
                        1,
                        function(t)
                            t:view_only()
                        end
                    ),
                    awful.button(
                        {modkey},
                        1,
                        function(t)
                            if client.focus then
                                client.focus:move_to_tag(t)
                            end
                        end
                    ),
                    awful.button({}, 3, awful.tag.viewtoggle),
                    awful.button(
                        {modkey},
                        3,
                        function(t)
                            if client.focus then
                                client.focus:toggle_tag(t)
                            end
                        end
                    ),
                    awful.button(
                        {},
                        4,
                        function(t)
                            awful.tag.viewprev(t.screen)
                        end
                    ),
                    awful.button(
                        {},
                        5,
                        function(t)
                            awful.tag.viewnext(t.screen)
                        end
                    )
                )
            }
        },
        {
            -- Middle widget
            layout = wibox.layout.fixed.horizontal,
            require("widgets.task-list").create(s)
        },
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            wibox.widget.textclock(),
            require("widgets.layoutbox").create(s)
        }
    }
end

return top_panel
