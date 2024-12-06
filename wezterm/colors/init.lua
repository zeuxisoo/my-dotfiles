local wezterm = require('wezterm')

local schemes = wezterm.color.get_builtin_schemes()
local scheme = schemes['Catppuccin Mocha']

-- function scheme_for_appearance(appearance)
--     if appearance:find 'Dark' then
--         return 'Catppuccin Mocha'
--     else
--         return 'Catppuccin Latte'
--     end
-- end
-- local scheme = schemes[scheme_for_appearance(wezterm.gui.get_appearance())]

return scheme
