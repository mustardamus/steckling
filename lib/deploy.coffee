fs     = require('fs')
log    = require('logule').init(module, 'DEPLOY')
mincer = require('mincer')
_      = require('underscore')
helper = require('./helper')

class Deploy
  constructor: (config) ->
    @env = new mincer.Environment()
    cwd  = process.cwd()

    @env.appendPath cwd

    for path in config.assets
      @env.appendPath "#{cwd}/#{path}"
      
    for asset, paths of config.deploy
      paths = [paths] if _.isString(paths)

      for path in paths
        path = "#{cwd}/#{path}"
        
        helper.createPathTree(path)
        @compileFile asset, path

  compileFile: (assetPath, destPath) ->
    asset = @env.findAsset(assetPath)

    if asset
      asset.compile (err, content) ->
        fs.writeFile destPath, content, ->
          log.info assetPath, '-->', destPath
    else
      log.error 'Can not find', assetPath, 'in asset pipeline'

module.exports = Deploy