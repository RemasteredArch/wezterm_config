# wezterm_config

My [WezTerm](https://wezterm.org/) configuration.
This config is built from scratch for the sake of fun and control;
and comes with no guarantees of functionality or stability.

Lots of behavior replicates [Windows Terminal](https://github.com/microsoft/terminal).

## Layout

- `./` is the root of the config.
  On Windows, this directory should be `%USERPROFILE/.wezterm/`.
  On Linux, this directory should be `$XDG_CONFIG_DIRECTORY/wezterm/`.
- `./wezterm.lua` is the entry point for the config.
  It does nothing but call `./config/init.lua`,
  the "true" entry point.
  On Windows, this file should be `%USERPROFILE/.wezterm.lua/`.
  This file does not need to be moved on Linux.
- `./config/` is the home for all configuration-related Lua.
- `./util/` holds useful Lua utilities.

## License

wezterm_config is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

wezterm_config is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with wezterm_config (located within [LICENSE](./LICENSE)).
If not, see <https://www.gnu.org/licenses/>.
