local util = require("util")
local wezterm = util.wezterm()

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

local ok, local_overrides = pcall(require, "config.overrides")
if ok then
    util.merge_into(config, local_overrides or {})
end

-- Disable tab bar in full screen.
wezterm.on("window-resized", function(window, _)
    local enable_tab_bar = not window:get_dimensions().is_full_screen

    local window_overrides = window:get_config_overrides() or {}
    -- Only set overrides if the setting will actually change to avoid needlessly firing the event.
    local will_change = window_overrides.enable_tab_bar ~= enable_tab_bar

    if will_change then
        window_overrides.enable_tab_bar = enable_tab_bar
        window:set_config_overrides(window_overrides)
    end
end)

return config
