local wezterm = require("wezterm")
local M = {}

function M.is_windows()
    return wezterm.target_triple:find("windows") ~= nil
end

function M.merge_tables(into, from)
    local into = into or {}
    local from = from or {}

    for k, v in pairs(from) do
      into[k] = v
    end

    return into
end

return M
