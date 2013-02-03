# run function arguments:
#   task - reference to Commander (https://github.com/visionmedia/commander.js)
#   log  - reference to Logule (https://github.com/clux/logule)

exports.run = (task, log) ->
  task
    .option('-a, --arg1 [str]', 'Arg1 is a string with no default')
    .option('-b, --arg2 [str]', 'Arg2 is a string with default', 'defaultValue')
    .option('-c, --arg3', 'Arg3 is a boolean')
    .parse(process.argv)

  log.info 'arg1', task.arg1
  log.info 'arg2', task.arg2
  log.info 'arg3', task.arg3