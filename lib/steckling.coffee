Server = require('./server')
Tasks  = require('./tasks')
_      = require('underscore')

module.exports = (config) ->
  config = {} if _.isEmpty(config)

  if process.argv.length is 2
    new Server(config)
  else
    new Tasks(config)