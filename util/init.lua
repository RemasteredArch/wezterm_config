--- @alias some boolean|string|number|integer|function|table|thread|userdata|lightuserdata `any` but non-nil

local wezterm = require("wezterm")
--- @cast wezterm -Config, +Wezterm
local M = {}


--- Equivalent to `require("wezterm")`, but with proper editor types.
---
--- This is a workaround for proper LSP annotations. [Lua Language
--- Server](https://luals.github.io/) will find `/wezterm.lua` in this repo and think it's the
--- source for `require(wezterm)`, and type that as returning a [`Config`](lua://Config), not
--- [`Wezterm`](lua://Wezterm). A cast can be used to manually change the type, and this function
--- wraps that so it doesn't have to be repeated in every file.
---
--- @return Wezterm
function M.wezterm()
    return wezterm
end

--- Detects whether WezTerm is running on Microsoft Windows.
---
--- @return boolean
function M.is_windows()
    return wezterm.target_triple:find("windows") ~= nil
end

--- For every `key` in `from`, set `into[key] = from[key]`.
---
--- @param into table<string, some>
--- @param from table<string, some>
function M.merge_into(into, from)
    assert(type(into) == "table" and type(from) == "table", "expecting tables")

    for k, v in pairs(from) do
        into[k] = v
    end
end

--- For every `key` in `keys`:
---
--- - If `from[key]` is a table, merge `from[key]` into `into[key]`.
--- - If `from[key]` is not a table, set `into[key] = from[key]`.
---
--- @param into table<string, some>
--- @param from table<string, some>
--- @param keys string[]
function M.merge_into_by_keys(into, from, keys)
    assert(type(into) == "table", "expecting table")
    assert(type(from) == "table", "expecting table")
    assert(type(keys) == "table", "expecting list of keys")

    for _, key in ipairs(keys) do
        local from_type = type(from[key])
        -- TODO: may be `nil` should be a legal value. It would effectively un-assign the key in
        -- `into`, which might be desirable behavior.
        assert(from_type ~= "nil", "expecting `from` to have every key")

        -- Non-tables should be directly assigned:
        if from_type ~= "table" then
            into[key] = from[key]
            goto continue
        end
        --- @cast from table<string, table>

        -- Otherwise, tables should be merged:

        if type(into[key]) ~= "table" then
            into[key] = {}
        end
        --- @cast into table<string, table>

        M.merge_into(into[key], from[key])

        ::continue::
    end
end

return M
