log = require('logule').init(module, 'TASKS CONTROLLER')
fs  = require('fs')

class tasksController
  constructor: (app) ->
    @app  = app
    @Task = require('../models/task')(app)

  index: (req, res) ->
    @Task.find (err, results) ->
      res.json results

  create: (req, res) ->
    task = new @Task(req.body)

    task.save (err, task) ->
      log.info 'task create', req.body
      res.json(task.toJSON())

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