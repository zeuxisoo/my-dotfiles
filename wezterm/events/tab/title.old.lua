local wezterm = require('wezterm')
local Cells = require('utils.cells')

local nf = wezterm.nerdfonts
local attr = Cells.attr

local GLYPH_SCIRCLE_LEFT = nf.ple_left_half_circle_thick --[[  ]]
local GLYPH_SCIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[  ]]
local GLYPH_CIRCLE = nf.fa_circle --[[  ]]
local GLYPH_ADMIN = nf.md_shield_half_full --[[ 󰞀 ]]
-- local GLYPH_LINUX = nf.cod_terminal_linux --[[  ]]
local GLYPH_DEBUG = nf.fa_bug --[[  ]]
local GLYPH_SEARCH = nf.fa_search --[[  ]]

local TITLE_INSET = {
    DEFAULT = 6,
    ICON = 8,
}

local M = {}

local RENDER_VARIANTS = {
    { 'scircle_left', 'title', 'padding',       'scircle_right' },
    { 'scircle_left', 'title', 'unseen_output', 'padding',       'scircle_right' },
    { 'scircle_left', 'admin', 'title',         'padding',       'scircle_right' },
    { 'scircle_left', 'admin', 'title',         'unseen_output', 'padding',      'scircle_right' },
}

local color_text_active_bg = '#bdfce5'
local color_text_active_fg = '#063970'
local color_text_inactive_bg = '#948375'
local color_text_inactive_fg = '#ffe0a7'
local color_text_hover_bg = '#95afe8'
local color_text_hover_fg = '#d7dbde'
local color_unseen_output_fg = '#f4934c'

local colors = {
    text_default          = { bg = color_text_inactive_bg, fg = color_text_inactive_fg },
    text_hover            = { bg = color_text_hover_bg, fg = color_text_hover_fg },
    text_active           = { bg = color_text_active_bg, fg = color_text_active_fg },

    unseen_output_default = { bg = color_text_inactive_bg, fg = color_unseen_output_fg },
    unseen_output_hover   = { bg = color_text_hover_bg, fg = color_unseen_output_fg },
    unseen_output_active  = { bg = color_text_active_bg, fg = color_unseen_output_fg },

    scircle_default       = { bg = 'rgba(0, 0, 0, 0.4)', fg = color_text_inactive_bg },
    scircle_hover         = { bg = 'rgba(0, 0, 0, 0.4)', fg = color_text_hover_bg },
    scircle_active        = { bg = 'rgba(0, 0, 0, 0.4)', fg = color_text_active_bg },
}

local function clean_process_name(proc)
    local a = string.gsub(proc, '(.*[/\\])(.*)', '%2')
    return a:gsub('%.exe$', '')
end

local function create_title(process_name, base_title, max_width, inset)
    local title

    if process_name:len() > 0 then
        title = process_name .. ' ~ ' .. base_title
    else
        title = base_title
    end

    if base_title == 'Debug' then
        title = GLYPH_DEBUG .. ' DEBUG'
        inset = inset - 2
    end

    if base_title:match('^InputSelector:') ~= nil then
        title = base_title:gsub('InputSelector:', GLYPH_SEARCH)
        inset = inset - 2
    end

    if title:len() > max_width - inset then
        local diff = title:len() - max_width + inset
        title = title:sub(1, title:len() - diff)
    else
        local padding = max_width - title:len() - inset
        title = title .. string.rep(' ', padding)
    end

    return title
end

-- Tab
local Tab = {}
Tab.__index = Tab

function Tab:new()
    local tab = {
        title = '',
        cells = Cells:new(),
        title_locked = false,
        locked_title = '',
        is_admin = false,
        unseen_output = false,
    }
    return setmetatable(tab, self)
end

function Tab:set_info(pane, max_width)
    local process_name = clean_process_name(pane.foreground_process_name)

    self.is_admin = (pane.title:match('^Administrator: ') or pane.title:match('(Admin)')) ~= nil
    self.unseen_output = pane.has_unseen_output

    local inset = self.is_admin and TITLE_INSET.ICON or TITLE_INSET.DEFAULT
    if self.unseen_output then
        inset = inset + 2
    end

    if self.title_locked then
        self.title = create_title('', self.locked_title, max_width, inset)
        return
    end

    self.title = create_title(process_name, pane.title, max_width, inset)
end

function Tab:create_cells()
    self.cells
        :add_segment('scircle_left', GLYPH_SCIRCLE_LEFT)
        :add_segment('admin', ' ' .. GLYPH_ADMIN)
        :add_segment('title', ' ', nil, attr(attr.intensity('Bold')))
        :add_segment('unseen_output', ' ' .. GLYPH_CIRCLE)
        :add_segment('padding', ' ')
        :add_segment('scircle_right', GLYPH_SCIRCLE_RIGHT)
end

function Tab:update_and_lock_title(title)
    self.locked_title = title
    self.title_locked = true
end

function Tab:update_cells(is_active, hover)
    local tab_state = 'default'

    if is_active then
        tab_state = 'active'
    elseif hover then
        tab_state = 'hover'
    end

    self.cells:update_segment_text('title', ' ' .. self.title)
    self.cells
        :update_segment_colors('scircle_left', colors['scircle_' .. tab_state])
        :update_segment_colors('admin', colors['text_' .. tab_state])
        :update_segment_colors('title', colors['text_' .. tab_state])
        :update_segment_colors('unseen_output', colors['unseen_output_' .. tab_state])
        :update_segment_colors('padding', colors['text_' .. tab_state])
        :update_segment_colors('scircle_right', colors['scircle_' .. tab_state])
end

function Tab:render()
    local variant_idx = self.is_admin and 3 or 1

    if self.unseen_output then
        variant_idx = variant_idx + 1
    end

    return self.cells:render(RENDER_VARIANTS[variant_idx])
end

local tab_list = {}

M.setup = function()
    wezterm.on('tabs.manual-update-tab-title', function(window, pane)
        window:perform_action(
            wezterm.action.PromptInputLine({
                description = wezterm.format({
                    { Foreground = { Color = '#FFFFFF' } },
                    { Attribute = { Intensity = 'Bold' } },
                    { Text = 'Enter new name for tab' },
                }),
                action = wezterm.action_callback(function(_window, _pane, line)
                    if line ~= nil then
                        local tab = window:active_tab()
                        local id = tab:tab_id()

                        tab_list[id]:update_and_lock_title(line)
                    end
                end),
            }),
            pane
        )
    end)

    wezterm.on('tabs.reset-tab-title', function(window, _pane)
        local tab = window:active_tab()
        local id = tab:tab_id()

        tab_list[id].title_locked = false
    end)

    wezterm.on('tabs.toggle-tab-bar', function(window, _pane)
        local effective_config = window:effective_config()

        window:set_config_overrides({
            enable_tab_bar = not effective_config.enable_tab_bar,
            background = effective_config.background,
        })
    end)

    wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
        if not tab_list[tab.tab_id] then
            tab_list[tab.tab_id] = Tab:new()
            tab_list[tab.tab_id]:set_info(tab.active_pane, max_width)
            tab_list[tab.tab_id]:create_cells()

            return tab_list[tab.tab_id]:render()
        end

        tab_list[tab.tab_id]:set_info(tab.active_pane, max_width)
        tab_list[tab.tab_id]:update_cells(tab.is_active, hover)

        return tab_list[tab.tab_id]:render()
    end)
end

return M
