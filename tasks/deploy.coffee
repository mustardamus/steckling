fs     = require('fs')
mincer = require('mincer')
_      = require('underscore')
helper = require('../lib/helper')

module.exports =
  description: 'Deploys from the asset pipeline'
  initialize: (log, config, env) ->
    @log = log
    @env = env
    @cwd = process.cwd()

    if _.isEmpty(config.deploy)
      log.error 'Nothing to deploy'
      return
      
    for asset, paths of config.deploy
      paths = [paths] if _.isString(paths)

      for path in paths
        path = "#{@cwd}/#{path}"
        
        helper.createPathTree(path)
        @compileFile asset, path

  compileFile: (assetPath, destPath) ->
    asset = @env.findAsset(assetPath)

    if asset
      asset.compile (err, content) =>
        fs.writeFile destPath, content, =>
          @log.info assetPath, '-->', destPath
    else
      @log.error 'Can not find', assetPath, 'in asset pipeline'