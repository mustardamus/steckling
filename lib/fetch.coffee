fs      = require('fs')
log     = require('logule').init(module, 'FETCH')
request = require('request')

class Fetch
  constructor: (config) ->
    @files = config.fetch

    unless @files
      log.info 'Nothing to fetch'
      return

    @fetchFiles()

  fetchFiles: ->
    for url, path of @files
      @downloadFile url, path

  downloadFile: (url, path) ->
    request url, (err, res, body) ->
      fs.writeFile path, body, ->
        log.info url, '-->', path

module.exports = Fetch