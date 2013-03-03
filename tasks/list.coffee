fs = require('fs')

module.exports =
  description: 'List all tasks'
  initialize: (log, config, env) ->
    folders  = [
      __dirname
      "#{process.cwd()}/tasks"
    ]

    for folder in folders
      continue unless fs.existsSync(folder)
      
      files = fs.readdirSync(folder)

      for file in files
        split = file.split('.')
        name  = split[0]
        ext   = split[1]

        if name and ext and ext is 'js' or ext is 'coffee'
          taskObj = require("#{folder}/#{file}")

          if taskObj and taskObj.description
            log.info name, '-', taskObj.description