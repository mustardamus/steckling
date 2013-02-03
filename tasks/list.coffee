fs     = require('fs')
create = require('../lib/create')

exports.run = (task, log) ->
  task
    .option('-o, --opts', 'Show options of tasks')
    .parse(process.argv)

  taskRoot  = __dirname
  taskFiles = fs.readdirSync(taskRoot)
  
  for taskFile in taskFiles
    taskName = taskFile.split('.')[0]

    unless task.opts
      log.info taskName
    else
      # this method expects exact strings
      # todo: make it more generic or use commanders help()

      content = fs.readFileSync("#{taskRoot}/#{taskFile}", 'utf-8')
      lines   = content.split("\n")
      opts    = []

      for line in lines
        if line.indexOf('.opt' + 'ion') isnt -1
          line      = line.substr(13, line.length - 15)
          lineSplit = line.split("', '")

          opts.push "#{lineSplit[0]}\t\t#{lineSplit[1]}"

      log.info taskName
      log.info "  #{opt}" for opt in opts