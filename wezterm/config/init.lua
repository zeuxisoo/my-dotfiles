local wezterm = require('wezterm')

local Config = {}
Config.__index = Config

function Config:new()
    local config = setmetatable({ options = {} }, self)
    return config
end

function Config:add(new_options)
    for k, v in pairs(new_options) do
        if self.options[k] ~= nil then
            wezterm.log_warn(
                '[Config] Duplicate config option detected: ',
                { old = self.options[k], new = new_options[k] }
            )

            goto continue
        end

        self.options[k] = v

        ::continue::
    end

    return self
end

return Config
