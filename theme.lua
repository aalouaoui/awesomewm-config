---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir()

local theme = {}

theme.name = "Default"

-- Font
theme.font = "Noto Sans 8"

-- background
theme.bg_normal = "#1f2430"
theme.bg_dark = "#000000"
theme.bg_focus = "#151821"
theme.bg_urgent = "#ed8274"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

-- Foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#e4e4e4"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- Window Gap Distance
theme.useless_gap = dpi(4)
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus = "#ff8a65"
theme.border_marked = theme.fg_urgent

-- From Pastel
-----------------
-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = "#ffffff1a"
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(5)

-- Titlebars
theme.titlebars_enabled = false

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(8)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "background.png"

-- You can use your own layout icons like this:
theme.layout_floating = themes_path .. "layouts/floating.png"
theme.layout_max = themes_path .. "layouts/maximized.png"
theme.layout_tile = themes_path .. "layouts/tiled.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Tela-dark"

return theme
