local util = require("util")
local wezterm = util.wezterm()
local act = wezterm.action

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

--- Register all base keybindings (`require("config.keys").keys`).
---
--- @param config table<string, some>
function M.register(config)
    util.merge_into_by_keys(config, M, { "keys" })
end

--- Registers keybindings for all items in `config.launch_menu`.
---
--- Registers `CTRL + SHIFT + i` for ever `i` starting from `1` and running until the end of
--- `config.launch_menu`.
---
--- @param config { keys: table[], launch_menu: table[] }
function M.register_launchers(config)
    if config.keys == nil then
        config.keys = {}
    end
    if config.launch_menu == nil then
        config.launch_menu = {}
    end

    for i, spawn_command in ipairs(config.launch_menu) do
        if i > 9 then
            break
        end

        table.insert(config.keys, {
            -- This is a hack, it doesn't respect users who rebind number keys. But I use QWERTY
            -- on a regular US layout keyboard, so it works fine for me.
            key = "phys:" .. tostring(i),
            mods = "CTRL|SHIFT",
            action = act.SpawnCommandInNewTab(spawn_command)
        })
    end
end

return M
