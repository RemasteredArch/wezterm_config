local wezterm = require("wezterm")
local act = wezterm.action
local util = require("util")

local M = {}

M.keys = {
    { key = "F11", action = act.ToggleFullScreen }
}

function M.register(config)
    util.merge_into_by_keys(config, M, { "keys" })
end

return M
