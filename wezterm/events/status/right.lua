local wezterm = require('wezterm')
local Cells = require('utils.cells')

--
local nf = wezterm.nerdfonts
local attr = Cells.attr

--
local GLYPH_SEPARATOR = nf.oct_dash
local GLYPH_DATE = nf.fa_calendar

--
local colors = {
    date      = { fg = '#eab676', bg = 'rgba(0, 0, 0, 0.4)' },
    separator = { fg = '#abdbe3', bg = 'rgba(0, 0, 0, 0.4)' }
}

--
local cells = Cells:new()

cells
    :add_segment('date_icon', GLYPH_DATE .. '  ', colors.date, attr(attr.intensity('Bold')))
    :add_segment('date_text', '', colors.date, attr(attr.intensity('Bold')))
    :add_segment('separator', ' ' .. GLYPH_SEPARATOR .. '  ', colors.separator)

--
local M = {}

M.setup = function()
    wezterm.on('update-right-status', function(window, _pane)
        cells
            :update_segment_text('date_text', wezterm.strftime('%a %H:%M:%S'))

        window:set_right_status(
            wezterm.format(
                cells:render({ 'date_icon', 'date_text', 'separator' })
            )
        )
    end)
end

return M
