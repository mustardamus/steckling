log = require('logule').init(module, 'APPLICATION CONTROLLER')
fs  = require('fs')

class applicationController
  constructor: (app) ->
    @app = app

  routeIndex: (req, res) ->
    indexFile = "#{__dirname}/../../client/layouts/default.html"

    fs.readFile indexFile, 'utf-8', (err, data) ->
      res.set 'Content-Type', 'text/html'
      res.send data

module.exports = applicationController