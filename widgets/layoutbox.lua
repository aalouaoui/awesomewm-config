local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xmargin = beautiful.xmargin
local ymargin = beautiful.ymargin

local layoutbox = {}

layoutbox.create = function(s)
    local mylayoutbox = wibox.container.margin(awful.widget.layoutbox(s), xmargin, xmargin, ymargin, ymargin)
    mylayoutbox:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    return mylayoutbox
end

return layoutbox
