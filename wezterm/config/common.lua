local wezterm = require('wezterm')

local hyperlink_rules = wezterm.default_hyperlink_rules()
-- table.insert(hyperlink_rules, {
--     regex = 'data:(?<mime>[\\w/\\-\\.]+);(?<encoding>\\w+),(?<data>.*)',
--     format = '$1 $2 $3',
--     highlight = 1,
-- })

return {
    -- behaviours
    automatically_reload_config = true,
    exit_behavior = 'CloseOnCleanExit', -- if the shell program exited with a successful status
    status_update_interval = 1000,

    -- scrollbar
    scrollback_lines = 8000,

    -- paste behaviours
    canonicalize_pasted_newlines = 'CarriageReturn', -- Newlines of any style are rewritten as CR

    hyperlink_rules = hyperlink_rules,
}
