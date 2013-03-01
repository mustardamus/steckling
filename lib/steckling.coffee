Server = require('./server')
Tasks  = require('./tasks')

class Steckling
  constructor: (config) ->
    argv = process.argv

    if argv.length is 2
      new Server(config)
    else
      new Tasks(config)


module.exports = Steckling