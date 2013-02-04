fs = require('fs')

rootDir = "#{__dirname}/.."
tmplDir = "#{rootDir}/templates"

copyFile = (src, dest) ->
  fs.writeFileSync(dest, fs.readFileSync(src))

exports.things =
  app : 'Create a complete App skeleton'
  task: 'Create a Task template'
  test: 'Create a Test template'

exports.create_app = (name, task, log) ->
  log.info 'create app :)'

exports.create_task = (name, task, log) ->
  src  = "#{tmplDir}/task.coffee"
  dest = "#{rootDir}/tasks/#{name}.coffee"
  
  copyFile(src, dest)
  log.info "Created Task template: ./tasks/#{name}.coffee"

exports.create_test = (name, task, log) ->
  src  = "#{tmplDir}/test.coffee"
  dest = "#{rootDir}/test/server/#{name}.coffee" # todo: create for client too

  copyFile(src, dest)
  log.info "Created Test template: ./test/server/#{name}.coffee"