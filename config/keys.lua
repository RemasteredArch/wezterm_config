local wezterm = require("wezterm")
local act = wezterm.action
local util = require("util")

local M = {}

M.keys = {
    {
        key = "F11",
        action = act.ToggleFullScreen
    },
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentTab({ confirm = false })
    },
    {
        key = "w",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentTab({ confirm = false })
    }
}

function M.register(config)
    config.keys = util.merge_tables(config.keys, M.keys)
end

return M
