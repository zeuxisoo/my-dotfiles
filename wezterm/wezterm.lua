local Config = require('config')

require('utils.background')
    :set_files()
    :random()

require('events.status.left').setup()
require('events.status.right').setup()
require('events.tab.title').setup()
require('events.tab.new-button').setup()

return Config:new()
    :add(require('config.appearance'))
    :add(require('config.fonts'))
    :add(require('config.bindings'))
    :add(require('config.common'))
    :add(require('config.launch'))
    .options
