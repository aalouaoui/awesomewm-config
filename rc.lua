-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library

-- Import Notifications Appearance
require("components.notifications")

-- Import Lock Scren
require("components.exit-screen")

-- Import Top Panel
local top_panel = require("components.top-panel")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nvim"
filemanager = "thunar"
browser = "firefox"
ide = "code"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.floating
}

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- {{{ Wibar
awful.screen.connect_for_each_screen(
    function(s)
        for i = 1, 6, 1 do
            awful.tag.add(
                i,
                {
                    icon = gears.filesystem.get_configuration_dir() .. "/icons/tags/" .. i .. ".png",
                    icon_only = true,
                    layout = awful.layout.suit.max,
                    screen = s,
                    selected = i == 1
                }
            )
        end

        set_wallpaper(s)
        top_panel.create(s)
    end
)
-- }}}

local keys = require("keys")
root.buttons(keys.mouseButtons)
root.keys(keys.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    -- { rule_any = {floating = true},
        -- properties = {
            -- placement = awful.placement.centered
        -- }
    -- },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Gcolor3",
                "gcolor3"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
                "Variety Images",
                "Qalculate!"
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {"normal", "dialog"}
        },
        properties = {titlebars_enabled = false}
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal(
    -- "mouse::enter",
    -- function(c)
        -- c:emit_signal("request::activate", "mouse_enter", {raise = false})
    -- end
-- )

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- }}}

-- Autostart Apps
awesome.connect_signal(
    "startup",
    function()
        local script = gears.filesystem.get_configuration_dir() .. "/config/autostart.sh"
        awful.spawn.with_shell(script)
    end
)

-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
