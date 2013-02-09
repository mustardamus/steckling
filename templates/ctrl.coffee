# Require your controller in routes.coffee!

log = require('logule').init(module, 'CTRL_NAME CONTROLLER')
fs  = require('fs')

class CTRL_NAMEController
  constructor: (app) ->
    @app = app

  serveFile: (req, res) ->
    path = "#{__dirname}/../../client/layouts/default.html"

    fs.readFile path, 'utf-8', (err, data) ->
      res.set 'Content-Type', 'text/html'
      res.send data

module.exports = CTRL_NAMEController