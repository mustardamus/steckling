fs    = require('fs')
cmder = require('commander')

exports.config = (task) ->
  task
    .usage('help [options]')
    .option('-l, --list', 'List all available tasks')
    .option('-t, --task [name]', 'Show help for a specific task')
    .parse(process.argv)

exports.run = (task, log) ->
  if task.list and !task.task
    taskRoot  = __dirname
    taskFiles = fs.readdirSync(taskRoot)

    log.info 'Available Tasks:'
  
    for taskFile in taskFiles
      taskName = taskFile.split('.')[0]
    
      log.info "  - #{taskName}"

    return

  if task.task
    orgTaskOpts = task.options.length
    taskObj     = require("./#{task.task}")

    if taskObj.config
      taskObj = taskObj.config(cmder)

      for i in [1..orgTaskOpts] # hack to remove all options from help output
        taskObj.options.shift() # that are available in 'help' task

      taskObj.help()

    return

  task.help()