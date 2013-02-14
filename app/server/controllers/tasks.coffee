log = require('logule').init(module, 'TASKS CONTROLLER')
fs  = require('fs')

class tasksController
  constructor: (app) ->
    @app = app

  index: (req, res) ->
    log.info 'tasks index'
    res.json([{id: 1, title: 'tester 1'}])

  create: (req, res) ->
    log.info 'task create'
    res.json({id: 3, title: 'created'})

  read: (req, res) ->
    log.info 'task read', req.params.id
    res.json({ id: 4, title: 'yop' })

  update: (req, res) ->
    log.info 'task update', req.params.id
    res.json({ id: 4, title: 'yes' })

  destroy: (req, res) ->
    log.info 'task detroy', req.params.id
    res.json({id: 4})

module.exports = tasksController