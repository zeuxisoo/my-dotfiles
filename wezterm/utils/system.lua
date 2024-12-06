local wezterm = require('wezterm')

local System = {}
System.__index = System

function System:new()
    local system = setmetatable({}, self)
    return system
end

function System:platform()
    local is_win = string.find(wezterm.target_triple, 'windows') ~= nil
    local is_linux = string.find(wezterm.target_triple, 'linux') ~= nil
    local is_mac = string.find(wezterm.target_triple, 'apple') ~= nil

    local os

    if is_win then
        os = 'windows'
    elseif is_linux then
        os = 'linux'
    elseif is_mac then
        os = 'mac'
    else
        error('Unknown platform')
    end

    return {
        os = os,
        is_win = is_win,
        is_linux = is_linux,
        is_mac = is_mac,
    }
end

return System:new()
