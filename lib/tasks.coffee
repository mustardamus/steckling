fs     = require('fs')
log    = require('logule').init(module, 'TASK')
Deploy = require('./deploy')
Fetch  = require('./fetch')

class Tasks
  constructor: (config) ->
    @config = config
    task    = process.argv[2]

    switch task
      when 'deploy' then new Deploy(config)
      when 'fetch'  then new Fetch(config)
      else @findTask(task)

  findTask: (taskName) ->
    cwd      = process.cwd()
    tasksDir = "#{cwd}/tasks"

    if fs.existsSync(tasksDir)
      tasks = fs.readdirSync(tasksDir)

      for task in tasks
        split = task.split('.')
        name  = split[0]
        ext   = split[1]

        if name is taskName
          taskObj = require("#{tasksDir}/#{task}")
          
          if taskObj.callback
            taskLog = require('logule').init(module, taskName.toUpperCase())
            taskObj.callback.call @, taskLog, @config, 'env'
          else
            log.error 'Found task', taskName, 'but no callback in it'

          return

    log.error 'Unknown task', task

module.exports = Tasks