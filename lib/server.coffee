log      = require('logule').init(module, 'SERVER')
express  = require('express')
mincer   = require('mincer')
_        = require('underscore')

class Server
  defaults:
    port: 8888

  constructor: (config) ->
    @app = express()
    @env = new mincer.Environment()
    @opt = _.extend(@defaults, config)

    @setupAssets()
    @setupStatics()
    @start()

  setupAssets: ->
    @app.use '/assets', mincer.createServer(@env)
    @env.appendPath "#{__dirname}/../"

    for path in @opt.assets
      @env.appendPath path

  setupStatics: ->
    for route, folders of @opt.routes
      folders = [folders] if _.isString(folders)

      for folder in folders
        @app.use route, express.static("#{__dirname}/../#{folder}")

  start: ->
    @app.listen @opt.port
    log.info "Server started on port #{@opt.port}"


module.exports = Server