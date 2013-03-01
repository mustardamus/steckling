_      = require('underscore')
Server = require('./server')
Deploy = require('./deploy')
Fetch  = require('./fetch')

class Steckling
  constructor: (config) ->
    switch _.last(process.argv)
      when 'deploy' then new Deploy(config)
      when 'fetch'  then new Fetch(config)
      else               new Server(config)


module.exports = Steckling