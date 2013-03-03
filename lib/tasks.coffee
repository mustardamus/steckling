fs        = require('fs')
logule    = require('logule')
log       = logule.init(module, 'TASK')
_         = require('underscore')

class Tasks
  constructor: (config) ->
    @config   = config
    @cwd      = process.cwd()
    taskName  = process.argv[2]
    @folders  = [
      "#{__dirname}/../tasks"
      "#{@cwd}/tasks"
    ]

    taskFile = @findTaskInFolders(taskName)

    if taskFile
      @callTask taskName, taskFile
    else
      log.error 'Unknown task', taskName

  findTaskInFolders: (taskName) ->
    ret = []

    for folder in @folders
      continue unless fs.existsSync(folder)

      files = fs.readdirSync(folder)

      for file in files
        split = file.split('.')
        name  = split[0]
        ext   = split[1]

        if name and ext and ext is 'js' or ext is 'coffee'
          if taskName is name
            ret.push "#{folder}/#{file}"

    if ret.length
      _.last(ret)
    else
      false

  callTask: (taskName, taskPath) ->
    task    = require(taskPath)
    taskLog = logule.init(module, taskName.toUpperCase())

    if task.initialize
      task.initialize.apply task, [taskLog, @config, 'pipeline']
    else
      log.error 'Found task', taskName, 'but no initialize function'


module.exports = Tasks