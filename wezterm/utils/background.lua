local wezterm = require('wezterm')
local colors = require('colors')

math.randomseed(os.time())
for i = 1, 5, 1 do
    math.random()
end

local GLOB_PATTERN = '*.{jpg,jpeg,png,gif}'

local Background = {}
Background.__index = Background

function Background:new()
    local inital = {
        current_idx = 1,
        files = {},
    }

    local background = setmetatable(inital, self)
    return background
end

function Background:initial_options()
    return self:_create_opts()
end

function Background:set_files()
    self.files = wezterm.glob(wezterm.config_dir .. '/backgrounds/' .. GLOB_PATTERN)
    return self
end

function Background:random(window)
    self.current_idx = math.random(#self.files)

    if window ~= nil then
        self:_set_opt(window, self:_create_opts())
    end
end

-- helper
function Background:_set_opt(window, background_opts)
    window:set_config_overrides({
        background = background_opts,
        enable_tab_bar = window:effective_config().enable_tab_bar,
    })
end

function Background:_create_opts()
    return {
        {
            source = { File = self.files[self.current_idx] },
            horizontal_align = 'Center',
            opacity = 0.56,
        },
        {
            source = { Color = colors.background },
            height = '120%',
            width = '120%',
            vertical_offset = '-10%',
            horizontal_offset = '-10%',
            opacity = 0.96,
        },
    }
end

return Background:new()
