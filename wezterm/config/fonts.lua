local wezterm = require('wezterm')

local font_family = 'FiraCode Nerd Font Mono'
local font_size = 13

return {
    font = wezterm.font({
        family = font_family,
        weight = 'Medium',
        harfbuzz_features = {
            'calt=0',
            'clig=0',
            'liga=0',
        },
    }),
    font_size = font_size,

    freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
    freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
