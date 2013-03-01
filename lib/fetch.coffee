fs      = require('fs')
log     = require('logule').init(module, 'FETCH')
request = require('request')

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
      @createDir(path)

      fs.writeFile "#{@cwd}/#{path}", body, ->
        log.info url, '-->', path

  createDir: (path) ->
    log.info  'create ', path

module.exports = Fetch