fs      = require('fs')
request = require('request')
helper  = require('../lib/helper')

module.exports =
  description: 'Fetch assets from the web'
  initialize: (log, config, env) ->
    @files = config.fetch
    @cwd   = process.cwd()

    unless @files
      log.info 'Nothing to fetch'
      return

    @fetchFiles()

  fetchFiles: ->
    for url, path of @files
      @downloadFile url, path

  downloadFile: (url, path) ->
    request url, (err, res, body) =>
      fullPath = "#{@cwd}/#{path}"

      helper.createPathTree(fullPath)
      fs.writeFile fullPath, body, ->
        log.info url, '-->', path