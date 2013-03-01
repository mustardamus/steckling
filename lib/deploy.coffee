fs     = require('fs')
log    = require('logule').init(module, 'DEPLOY')
mincer = require('mincer')

class Deploy
  constructor: (config) ->
    @env = new mincer.Environment()

    @env.appendPath "#{__dirname}/../" #cwd

    for path in config.assets
      @env.appendPath path

    for asset, path of config.deploy
      @compileFile asset, path
      console.log asset, path

  compileFile: (asset, path) ->
    @env.findAsset(asset).compile (err, content) ->
      fs.writeFile path, content, ->
        log.info asset, '-->', path

module.exports = Deploy