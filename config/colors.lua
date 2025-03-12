local util = require("util")
local wezterm = util.wezterm()

local M = {}

local function color_mode()
    if wezterm.gui and wezterm.gui.get_appearance():find("Light") then
        return "Light"
    end

    return "Dark"
end

-- Colors from Catppuccin.
--
-- Copyright 2021 Catppuccin; MIT license.
--
-- <https://catppuccin.com/>
local catppuccin_latte = {
    lavendar = "#7287fd",
    text = "#4c4f69",
    overlay_0 = "#9ca0b0",
    -- Also used for subtle text.
    overlay_1 = "#8c8fa1",
    surface_0 = "#ccd0da",
    base = "#eff1f5",
    mantle = "#e6e9ef",
    crust = "#dce0e8"
}
local catppuccin_mocha = {
    lavendar = "#b4befe",
    text = "#cdd6f4",
    overlay_0 = "#6c7086",
    -- Also used for subtle text.
    overlay_1 = "#7f849c",
    surface_0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b"
}
local catppuccin

if color_mode() == "Dark" then
    catppuccin = catppuccin_mocha
    M.color_scheme = "Catppuccin Mocha"
else
    catppuccin = catppuccin_latte
    M.color_scheme = "Catppuccin Latte"
end

-- Active/inactive: when the window is/is not focused.
M.window_frame = {
    -- Color of the background strip of the tab bar (applies to the fancy tab bar).
    active_titlebar_bg = catppuccin.crust,
    inactive_titlebar_bg = catppuccin.mantle

    -- Seemingly Wayland-exclusive settings:

    -- Text
    -- `active_titlebar_fg = catppuccin.text,`
    -- `inactive_titlebar_fg = catppuccin.overlay_1,`

    -- `active_titlebar_border_bottom`
    -- `inactive_titlebar_border_bottom`

    -- `button_fg`
    -- `button_bg`

    -- `button_hover_fg`
    -- `button_hover_bg`
}

M.colors = {
    tab_bar = {
        -- The color of the thin bar separating inactive tabs.
        inactive_tab_edge = catppuccin.overlay_0,

        -- Color of the background strip of the tab bar (applies to the retro tab bar).
        background = catppuccin.crust,

        -- A window's focused tab.
        --
        -- The other tables in `tab_bar.*` take the same options.
        active_tab = {
            -- The color of the background area for the tab.
            bg_color = catppuccin.base,
            -- The color of the text for the tab.
            fg_color = catppuccin.text,

            -- Text intensity.
            --
            -- `"Half"`, `"Normal"` (default), or `"Bold"`.
            intensity = "Bold",

            -- Text underline.
            --
            -- `"None"` (default), `"Single"`, or `"Double"`.
            underline = "None",

            -- Italicized text.
            --
            -- Default `false` (non-italicized text).
            italic = false,

            -- Struck-through text.
            --
            -- Default `false` (no strike).
            strikethrough = false
        },

        -- The unfocused tabs of in window.
        inactive_tab = {
            -- The color of the background area for the tab.
            bg_color = catppuccin.mantle,
            -- The color of the text for the tab.
            fg_color = catppuccin.overlay_1,

            -- Text intensity.
            --
            -- `"Half"`, `"Normal"` (default), or `"Bold"`.
            intensity = "Normal"
        },

        -- Inactive tabs when hovered over by a mouse cursor.
        inactive_tab_hover = {
            bg_color = catppuccin.surface_0,
            fg_color = catppuccin.text
        },

        -- The new tab button that you can press to create new tabs.
        new_tab = {
            -- The color of the background area for the button.
            bg_color = catppuccin.mantle,
            -- The color of the button's icon.
            fg_color = catppuccin.overlay_1
        },

        -- The new tab button when hovered over by a mouse cursor.
        new_tab_hover = {
            -- The color of the background area for the button.
            bg_color = catppuccin.base,
            -- The color of the button's icon.
            fg_color = catppuccin.text
        }
    }
}

function M.register(config)
    util.merge_into_by_keys(config, M, {
        "color_scheme",
        "colors",
        "window_frame"
    })
end

return M
