create = require('../lib/create')

exports.config = (task) ->
  task
    .usage('new [options]')
    .option('-t, --thing [str]', 'What thing to create (default: app)', 'app')
    .option('-n, --name [str]', 'Name of the thing to create')
    .parse(process.argv)

exports.run = (task, log) ->
  unless task.name
    log.error 'Set the name of the thing you want to create'
    task.help()
    return

  taskDesc   = create.things[task.thing]
  createFunc = create["create_#{task.thing}"]

  if taskDesc and createFunc
    log.info taskDesc
    createFunc(task.name, task, log)
  else
    log.error "Create description/function for '#{task.thing}' not found"