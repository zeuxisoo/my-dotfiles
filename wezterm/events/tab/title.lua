local wezterm = require('wezterm')

--
local GLYPH_SEMI_CIRCLE_LEFT = ''
local GLYPH_SEMI_CIRCLE_RIGHT = ''
local GLYPH_POINT = '󰫢 '
local GLYPH_ADMIN = '󰖳 '

--
local color_text_active_bg = '#bdfce5'
local color_text_active_fg = '#063970'
local color_text_inactive_bg = '#948375'
local color_text_inactive_fg = '#ffe0a7'
local color_text_hover_bg = '#95afe8'
local color_text_hover_fg = '#d7dbde'
local color_unseen_output_fg = '#f2761d'

--
local M = {}

M.cells = {}
M.colors = {
    default = {
        bg = color_text_inactive_bg,
        fg = color_text_inactive_fg,
    },
    is_active = {
        bg = color_text_active_bg,
        fg = color_text_active_fg,
    },

    hover = {
        bg = color_text_hover_bg,
        fg = color_text_hover_fg,
    },
}

M.set_process_name = function(s)
    local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
    return a:gsub('%.exe$', '')
end

M.set_title = function(process_name, static_title, active_title, max_width, inset)
    local title
    inset = inset or 6

    if process_name:len() > 0 and static_title:len() == 0 then
        title = ' ' .. process_name .. ' ~ '
    elseif static_title:len() > 0 then
        title = '󰌪 ' .. static_title .. ' ~ '
    else
        title = '󰌽 ' .. active_title .. ' ~ '
    end

    if title:len() > max_width - inset then
        local diff = title:len() - max_width + inset
        title = wezterm.truncate_right(title, title:len() - diff)
    end

    return title
end

M.check_if_admin = function(p)
    if p:match('^Administrator: ') then
        return true
    end
    return false
end

M.push = function(bg, fg, attribute, text)
    table.insert(M.cells, { Background = { Color = bg } })
    table.insert(M.cells, { Foreground = { Color = fg } })
    table.insert(M.cells, { Attribute = attribute })
    table.insert(M.cells, { Text = text })
end

M.setup = function()
    wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
        M.cells = {}

        local bg
        local fg
        local process_name = M.set_process_name(tab.active_pane.foreground_process_name)
        local is_admin = M.check_if_admin(tab.active_pane.title)
        local title = M.set_title(process_name, tab.tab_title, tab.active_pane.title, max_width, (is_admin and 8))

        if tab.is_active then
            bg = M.colors.is_active.bg
            fg = M.colors.is_active.fg
        elseif hover then
            bg = M.colors.hover.bg
            fg = M.colors.hover.fg
        else
            bg = M.colors.default.bg
            fg = M.colors.default.fg
        end

        local has_unseen_output = false
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then
                has_unseen_output = true
                break
            end
        end

        -- Left semi-circle
        M.push(M.colors.is_active.fg, bg, { Intensity = 'Bold' }, GLYPH_SEMI_CIRCLE_LEFT)

        -- Admin Icon
        if is_admin then
            M.push(bg, fg, { Intensity = 'Bold' }, ' ' .. GLYPH_ADMIN)
        end

        -- Title
        M.push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)

        -- Unseen output alert
        if has_unseen_output then
            M.push(bg, color_unseen_output_fg, { Intensity = 'Bold' }, GLYPH_POINT)
        end

        -- Right padding
        M.push(bg, fg, { Intensity = 'Bold' }, ' ')

        -- Right semi-circle
        M.push(M.colors.is_active.fg, bg, { Intensity = 'Bold' }, GLYPH_SEMI_CIRCLE_RIGHT)

        return M.cells
    end)
end

return M
