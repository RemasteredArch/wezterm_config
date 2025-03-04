local wezterm = require("wezterm")
local act = wezterm.action
local util = require("util")

local M = {}

M.keys = {
    { key = "F11", action = act.ToggleFullScreen }
}

function M.register(config)
    config.keys = util.merge_tables(config.keys, M.keys)
end

return M
