local wezterm = require('wezterm')
local system = require('utils.system')
local background = require('utils.background')
local act = wezterm.action

local platform = system:platform()

local mod = {}

if platform.is_mac then
    mod.SUPER = 'CMD'
    mod.OPT = 'OPT'
    mod.SUPER_CTRL = 'CMD|CTRL'
    mod.SUPER_SHIFT = 'CMD|SHIFT'
elseif platform.is_win or platform.is_linux then
    mod.SUPER = 'SUPER'
    mod.OPT = 'ALT'
    mod.SUPER_CTRL = 'SUPER|CTRL'
    mod.SUPER_SHIFT = 'SUPER|SHIFT'
end

local keys = {
    -- misc/useful
    { mods = 'NONE',          key = 'F1',    action = 'ActivateCopyMode' },
    { mods = 'NONE',          key = 'F2',    action = act.ActivateCommandPalette },
    { mods = 'NONE',          key = 'F4',    action = act.ShowLauncher },
    { mods = 'NONE',          key = 'F5',    action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    { mods = 'NONE',          key = 'F6',    action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
    { mods = 'NONE',          key = 'F12',   action = act.ShowDebugOverlay },
    { mods = mod.SUPER,       key = 'Enter', action = act.ToggleFullScreen },
    { mods = mod.SUPER,       key = 'k',     action = act.ClearScrollback('ScrollbackAndViewport') },
    { mods = mod.SUPER,       key = 'q',     action = act.QuitApplication },
    { mods = mod.SUPER_SHIFT, key = 'p',     action = act.ActivateCommandPalette }, -- same: F2
    {
        mods = mod.SUPER,
        key = 'f',
        action = wezterm.action_callback(function(window, pane)
            window:perform_action(act.Search({ CaseInSensitiveString = '' }), pane)
            window:perform_action(
                act.Multiple({
                    act.CopyMode('ClearPattern'),
                    act.CopyMode('ClearSelectionMode'),
                    act.CopyMode('MoveToScrollbackBottom')
                }),
                pane
            )
        end)
    },
    {
        mods = mod.SUPER_CTRL,
        key = 'u',
        action = wezterm.action.QuickSelectArgs({
            label = 'open url',
            patterns = {
                '\\((https?://\\S+)\\)',
                '\\[(https?://\\S+)\\]',
                '\\{(https?://\\S+)\\}',
                '<(https?://\\S+)>',
                '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end),
        }),
    },

    -- cursor movement
    { mods = mod.SUPER,       key = 'LeftArrow',  action = act.SendString('\x1bOH') },
    { mods = mod.SUPER,       key = 'RightArrow', action = act.SendString('\x1bOF') },
    { mods = mod.SUPER,       key = 'Backspace',  action = act.SendString('\x15') },
    { mods = mod.OPT,         key = 'LeftArrow',  action = act.SendString('\x1bb') },
    { mods = mod.OPT,         key = 'RightArrow', action = act.SendString('\x1bf') },

    -- copy/paste
    { mods = mod.SUPER,       key = 'c',          action = act.CopyTo('Clipboard') },
    { mods = mod.SUPER,       key = 'v',          action = act.PasteFrom('Clipboard') },

    -- tabs
    -- tabs: spawn+close
    { mods = mod.SUPER,       key = 't',          action = act.SpawnTab('DefaultDomain') },
    { mods = mod.SUPER_CTRL,  key = 'w',          action = act.CloseCurrentTab({ confirm = false }) },

    -- tabs: navigation
    { mods = mod.SUPER_SHIFT, key = '[',          action = act.ActivateTabRelative(-1) },
    { mods = mod.SUPER_SHIFT, key = ']',          action = act.ActivateTabRelative(1) },
    { mods = mod.SUPER,       key = '[',          action = act.MoveTabRelative(-1) },
    { mods = mod.SUPER,       key = ']',          action = act.MoveTabRelative(1) },

    -- tab: change title
    { mods = mod.SUPER,       key = '0',          action = act.EmitEvent('tabs.manual-update-tab-title') },
    { mods = mod.SUPER_SHIFT, key = ')',          action = act.EmitEvent('tabs.reset-tab-title') }, -- equals: `cmd+shift+0`

    -- tab: hide tab-bar
    { mods = mod.SUPER,       key = '9',          action = act.EmitEvent('tabs.toggle-tab-bar'), },

    -- window --
    -- window: spawn windows
    { mods = mod.SUPER,       key = 'n',          action = act.SpawnWindow },

    -- window: zoom window
    {
        mods = mod.SUPER,
        key = '-', -- `-`
        action = wezterm.action_callback(function(window, _pane)
            local dimensions = window:get_dimensions()

            if dimensions.is_full_screen then
                return
            end

            local new_width = dimensions.pixel_width - 50
            local new_height = dimensions.pixel_height - 50

            window:set_inner_size(new_width, new_height)
        end)
    },
    {
        mods = mod.SUPER,
        key = '=', -- `+`
        action = wezterm.action_callback(function(window, _pane)
            local dimensions = window:get_dimensions()

            if dimensions.is_full_screen then
                return
            end

            local new_width = dimensions.pixel_width + 50
            local new_height = dimensions.pixel_height + 50

            window:set_inner_size(new_width, new_height)
        end)
    },

    -- background controls
    {
        mods = mod.SUPER,
        key = [[/]],
        action = wezterm.action_callback(function(window, _pane)
            background:random(window)
        end),
    },

    -- panes
    -- panes: split panes
    { mods = mod.SUPER,       key = [[\]],   action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { mods = mod.SUPER_SHIFT, key = [[\]],   action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

    -- panes: zoom+close pane
    { mods = mod.SUPER_SHIFT, key = 'Enter', action = act.TogglePaneZoomState },
    { mods = mod.SUPER,       key = 'w',     action = act.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { mods = mod.SUPER_SHIFT, key = 'k',     action = act.ActivatePaneDirection('Up') },
    { mods = mod.SUPER_SHIFT, key = 'j',     action = act.ActivatePaneDirection('Down') },
    { mods = mod.SUPER_SHIFT, key = 'h',     action = act.ActivatePaneDirection('Left') },
    { mods = mod.SUPER_SHIFT, key = 'l',     action = act.ActivatePaneDirection('Right') },
    {
        mods = mod.SUPER,
        key = 'p',
        action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
    },

    -- panes: scroll pane
    { mods = mod.SUPER, key = 'u',        action = act.ScrollByLine(-5) },
    { mods = mod.SUPER, key = 'd',        action = act.ScrollByLine(5) },
    { mods = 'NONE',    key = 'PageUp',   action = act.ScrollByPage(-0.75) },
    { mods = 'NONE',    key = 'PageDown', action = act.ScrollByPage(0.75) },

    -- key-tables
    -- key-tables: resizes fonts
    {
        mods = 'LEADER',
        key = 'f',
        action = act.ActivateKeyTable({
            name = 'resize_font',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
    -- key-tables: resize panes
    {
        mods = 'LEADER',
        key = 'p',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
}

local key_tables = {
    resize_font = {
        { key = 'k',      action = act.IncreaseFontSize },
        { key = 'j',      action = act.DecreaseFontSize },
        { key = 'r',      action = act.ResetFontSize },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

local mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        mods = 'CTRL',
        event = { Up = { streak = 1, button = 'Left' } },
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    disable_default_key_bindings = true,
    -- disable_default_mouse_bindings = true,

    leader = { mods = mod.SUPER, key = 'l', },
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
