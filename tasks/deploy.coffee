fs       = require('fs')
express  = require('express')
mincer   = require('mincer')
uglify   = require('uglify-js')
cleancss = require('clean-css')
config   = require('../app/server/config')

exports.config = (task) ->
  task.usage('deploy')

exports.run = (task, log) ->
  publicDir = "#{__dirname}/../public"
  assetsDir = "#{publicDir}/assets"
  app       = express()
  env       = new mincer.Environment()

  config.config(app)

  for path in app.get('assets')
    env.appendPath(path)

  env.findAsset('bundle.js').compile (err, asset) ->
    content = asset.toString()
    min     = uglify.minify(content, { fromString: true })
    size    = Math.floor(min.code.length / 1024)

    fs.writeFileSync "#{assetsDir}/bundle.js", min.code
    log.info "Generated and minified bundle.js (#{size} kb)"

  env.findAsset('bundle.css').compile (err, asset) ->
    content = asset.toString()
    min     = cleancss.process(content)
    size    = Math.floor(min.length / 1024)

    fs.writeFile "#{assetsDir}/bundle.css", min
    log.info "Generated and minified bundle.css (#{size} kb)"