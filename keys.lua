local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local menubar = require("menubar")

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"
local ctrlkey = "Control"
local shiftkey = "Shift"

-- define module table
local keys = {}

local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local function switch_launch(cmd, tag)
    local tag = awful.tag.find_by_name(awful.screen.focused(), tag)
    tag:view_only()
    awful.spawn(cmd, {tag = tag.name})
end

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

keys.mouseButtons = gears.table.join(awful.button({}, 4, awful.tag.viewprev), awful.button({}, 5, awful.tag.viewnext))

keys.globalkeys =
    gears.table.join(
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    awful.key(
        {altkey},
        "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),
    -- Standard program
    awful.key(
        {modkey},
        "t",
        function()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "e",
        function()
            switch_launch(filemanager, "4")
        end,
        {description = "open a file manager", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "b",
        function()
            switch_launch(browser, "2")
        end,
        {description = "open a browser", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "c",
        function()
            switch_launch(ide, "3")
        end,
        {description = "open an IDE", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "Escape",
        function()
            -- emit signal to show the exit screen
            awesome.emit_signal("show_exit_screen")
        end,
        {description = "toggle exit screen", group = "hotkeys"}
    ),
    awful.key({modkey, ctrlkey}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ctrlkey, altkey}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key(
        {modkey},
        "Tab",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    -- Menubar
    awful.key(
        {modkey},
        "r",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    ),
    -- =========================================
    -- FUNCTION KEYS
    -- =========================================

    -- Brightness
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            awful.spawn("xbacklight -inc 10", false)
        end,
        {description = "+10% Brightness", group = "hotkeys"}
    ),
    awful.key(
        {modkey, ctrlkey},
        "Up",
        function()
            awful.spawn("xbacklight -inc 10", false)
        end,
        {description = "+10% Brightness", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            awful.spawn("xbacklight -dec 10", false)
        end,
        {description = "-10% Brightness", group = "hotkeys"}
    ),
    awful.key(
        {modkey, ctrlkey},
        "Down",
        function()
            awful.spawn("xbacklight -dec 10", false)
        end,
        {description = "-10% Brightness", group = "hotkeys"}
    ),
    -- ALSA volume control
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%+", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume up", group = "hotkeys"}
    ),
    awful.key(
        {modkey, ctrlkey},
        "Right",
        function()
            awful.spawn("amixer -D pulse sset Master 5%+", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume up", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%-", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume down", group = "hotkeys"}
    ),
    awful.key(
        {modkey, ctrlkey},
        "Left",
        function()
            awful.spawn("amixer -D pulse sset Master 5%-", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume down", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86AudioMute",
        function()
            awful.spawn("amixer -D pulse set Master 1+ toggle", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "toggle mute", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86AudioNext",
        function()
            awful.spawn("playerctl next", false)
        end,
        {description = "next music", group = "hotkeys"}
    ),
    awful.key(
        {modkey, shiftkey},
        "Right",
        function()
            awful.spawn("playerctl next", false)
        end,
        {description = "next music", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86AudioPrev",
        function()
            awful.spawn("playerctl previous", false)
        end,
        {description = "previous music", group = "hotkeys"}
    ),
    awful.key(
        {modkey, shiftkey},
        "Left",
        function()
            awful.spawn("playerctl previous", false)
        end,
        {description = "previous music", group = "hotkeys"}
    ),
    awful.key(
        {},
        "XF86AudioPlay",
        function()
            awful.spawn("playerctl play-pause", false)
        end,
        {description = "play/pause music", group = "hotkeys"}
    ),
    awful.key(
        {modkey, shiftkey},
        "Down",
        function()
            awful.spawn("playerctl play-pause", false)
        end,
        {description = "play/pause music", group = "hotkeys"}
    )
)

keys.clientkeys =
    gears.table.join(
    awful.key(
        {modkey},
        "Return",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {modkey},
        "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key({modkey}, "f", awful.client.floating.toggle, {description = "toggle floating", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys =
        gears.table.join(
        keys.globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, shiftkey},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        )
    )
end

keys.clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

return keys
