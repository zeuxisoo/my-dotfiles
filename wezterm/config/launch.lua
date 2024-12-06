local system = require('utils.system')

local platform = system:platform()

local options = {
    default_prog = {},
    launch_menu = {},
}

if platform.is_win then
    options.default_prog = { 'pwsh', '-NoLogo' }
    options.launch_menu = {
        { label = ' PowerShell v7', args = { 'pwsh', '-NoLogo' } },
        { label = ' PowerShell v1', args = { 'powershell' } },
        { label = ' Cmd', args = { 'cmd' } },
        { label = ' Nushell', args = { 'nu' } },
        {
            label = ' Git Bash',
            args = { os.getenv('HOMEDRIVE') .. os.getenv('HOMEPATH') .. '\\scoop\\apps\\git\\current\\bin\\bash.exe' },
        },
    }
elseif platform.is_mac then
    options.default_prog = { 'zsh', '-l' }
    options.launch_menu = {
        { label = ' Zsh', args = { 'zsh', '-l' } },
        { label = ' Bash', args = { 'bash', '-l' } },
        { label = ' Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
        { label = ' Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
    }
elseif platform.is_linux then
    options.default_prog = { 'zsh', '-l' }
    options.launch_menu = {
        { label = ' Zsh', args = { 'zsh', '-l' } },
        { label = ' Bash', args = { 'bash', '-l' } },
        { label = ' Fish', args = { 'fish', '-l' } },
    }
end

return options
