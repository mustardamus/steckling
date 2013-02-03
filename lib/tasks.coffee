fs   = require('fs')
task = require('commander')
log  = require('logule').init(module, 'TASKS')

exports.route = ->
  rootDir   = "#{__dirname}/.."
  tasksDir  = "#{rootDir}/tasks"
  taskName  = process.argv[2] or 'help'
  taskFiles = fs.readdirSync(tasksDir)
  taskFound = false

  for taskFile in taskFiles
    nameSplit = taskFile.split('.')

    if nameSplit[0] is taskName
      taskFound = true
      break

  if taskFound
    taskObj = require("#{tasksDir}/#{taskName}")

    if taskObj.config and taskObj.run
      taskLog = require('logule').init(module, taskName.toUpperCase())
      taskCfg = taskObj.config(task)

      taskObj.run(taskCfg, taskLog)
    else
      log.error "Task '#{taskName}' needs 'config' and 'run' functions"
  else
    log.error "Unknown task '#{taskName}' (./tasks/#{taskName}.coffee)"