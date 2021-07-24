local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local layoutbox = {}

layoutbox.create = function(s)
    local icondpi = 4
    local mylayoutbox =
        wibox.container.margin(awful.widget.layoutbox(s), dpi(icondpi), dpi(icondpi), dpi(icondpi), dpi(icondpi))
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
