local wezterm = require("wezterm")
local util = require("util")

local config = wezterm.config_builder()

-- Also registers tab bar configuration.
require("config.colors").register(config)
require("config.keys").register(config)

config.font = wezterm.font("Cascadia Code")
config.font_size = 14
config.default_cursor_style = "BlinkingBar"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.canonicalize_pasted_newlines = "LineFeed"
config.window_close_confirmation = "NeverPrompt"

if util.is_windows() then
    config.default_prog = { "ubuntu2404.exe" }

    config.launch_menu = {
        {
            label = "PowerShell",
            args = { "powershell.exe", "-NoLogo" }
        },
        {
            label = "Command Prompt",
            args = { "cmd.exe" }
        },
        {
            label = "Ubuntu 24.04",
            args = { "ubuntu2404.exe" }
        }
    }
end

require("config.keys").register_launchers(config)

local ok, overrides = pcall(require, "config.overrides")
if ok then
    util.merge_into(config, overrides or {})
end

return config
