log = require('logule').init(module, 'SHEETS CONTROLLER')
fs  = require('fs')

class sheetsController
  constructor: (app) ->
    @app   = app
    @Sheet = require('../models/sheet')(app)

  index: (req, res) ->
    @Sheet.find (err, results) ->
      res.json results

  create: (req, res) ->
    sheet = new @Sheet(req.body)

    sheet.save (err, task) ->
      log.info 'sheet create', req.body
      res.json(sheet.toJSON())

  read: (req, res) ->
    log.info 'sheet read', req.params.id
    res.json({ id: 4, title: 'yop' })

  update: (req, res) ->
    log.info 'sheet update', req.params.id
    res.json({ id: 4, title: 'yes' })

  destroy: (req, res) ->
    log.info 'sheet detroy', req.params.id
    res.json({id: 4})

module.exports = sheetsController