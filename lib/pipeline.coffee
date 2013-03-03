mincer = require('mincer')

class Pipeline
  constructor: (config) ->
    @env = new mincer.Environment()
    cwd  = process.cwd()

    @env.appendPath cwd

    if config.assets
      for path in config.assets
        @env.appendPath "#{cwd}/#{path}"


module.exports = Pipeline