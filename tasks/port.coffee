Server = require('../lib/server')

module.exports =
  description: 'Start server on specific port'
  initialize: (log, config, env) ->
    port = process.argv[3]          # pass in the command line options to the init func

    if port
      new Server({ port: port })
    else
      log.error 'Please specify a port'