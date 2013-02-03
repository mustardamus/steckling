fs = require('fs')

rootDir     = "#{__dirname}/.."
templateDir = "#{rootDir}/templates"

exports.things =
  app : 'Create a complete App skeleton'
  task: 'Create a Task template'

exports.create_app = (name, task, log) ->
  log.info 'create app :)'

exports.create_task = (name, task, log) ->
  tempSrc  = "#{templateDir}/task.coffee"
  tempDest = "#{rootDir}/tasks/#{name}.coffee"
  content  = fs.readFileSync(tempSrc)

  fs.writeFileSync(tempDest, content)
  log.info "Created Task template: ./tasks/#{name}.coffee"