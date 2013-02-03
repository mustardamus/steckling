fs   = require('fs')
task = require('commander')
log  = require('logule').init(module, 'TASKS')

exports.route = ->
  rootDir   = "#{__dirname}/.."
  tasksDir  = "#{rootDir}/tasks"
  taskName  = process.argv[2] or 'list'
  taskFiles = fs.readdirSync(tasksDir)
  taskFound = false

  for taskFile in taskFiles
    nameSplit = taskFile.split('.')

    if nameSplit[0] is taskName
      taskFound = true
      break

  if taskFound
    taskObj = require("#{tasksDir}/#{taskName}")

    if taskObj.run
      taskLog = require('logule').init(module, taskName.toUpperCase())

      taskObj.run(task, taskLog)
    else
      log.error "Task '#{taskName}' needs a export function 'run':   exports.run = (task, log) ->"
  else
    log.error "Unknown task '#{taskName}' (./tasks/#{taskName}.coffee)"