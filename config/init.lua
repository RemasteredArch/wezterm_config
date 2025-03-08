local wezterm = require("wezterm")
local util = require("util")

local config = wezterm.config_builder()

-- Also registers tab bar configuration.
require("config.colors").register(config)
require("config.keys").register(config)

config.font = wezterm.font("Cascadia Code")
config.font_size = 13
config.default_cursor_style = "BlinkingBar"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.canonicalize_pasted_newlines = "LineFeed"

if util.is_windows() then
    config.default_prog = { "ubuntu2404.exe" }
end

local ok, overrides = pcall(require, "config.overrides")

if ok then
    util.merge_into(config, overrides or {})
end

return config
