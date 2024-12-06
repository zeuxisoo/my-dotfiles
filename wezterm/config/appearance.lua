local gpu_adapters = require('utils.gpu.adapter')
local background = require('utils.background')
local colors = require('colors')

return {
    max_fps = 60,
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',
    webgpu_preferred_adapter = gpu_adapters:pick_best(),

    -- cursor
    animation_fps = 60,
    cursor_blink_ease_in = 'EaseOut',
    cursor_blink_ease_out = 'EaseOut',
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 700,

    -- color scheme
    colors = colors,

    -- background
    background = background:initial_options(),

    -- scrollbar
    enable_scroll_bar = true,

    -- tab bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = false,
    tab_max_width = 25,
    show_tab_index_in_tab_bar = false,
    switch_to_last_active_tab_when_closing_tab = true,

    -- window
    -- window_background_opacity = 0.95, -- control by `utils.background._create_opts`
    window_decorations = 'RESIZE|MACOS_FORCE_DISABLE_SHADOW',
    initial_cols = 100,
    initial_rows = 35,
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },
    adjust_window_size_when_changing_font_size = false,
    window_close_confirmation = 'NeverPrompt',
    window_frame = {
        -- if using `use_fancy_tab_bar: true`
        active_titlebar_bg = '#090909',
    },
    inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 1.0,
    },
}
