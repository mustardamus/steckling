fs      = require('fs')
log     = require('logule').init(module, 'FETCH')
request = require('request')
helper  = require('./helper')

class Fetch
  constructor: (config) ->
    @files = config.fetch
    @cwd   = cwd = process.cwd()

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


module.exports = Fetch