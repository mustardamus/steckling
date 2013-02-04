expect = require('expect.js')
fs     = require('fs')
tasks  = require('../../lib/tasks')

tmpDir = "#{__dirname}/../../tmp"
ttFile = "#{tmpDir}/testtask.coffee"

describe 'tasks routing', ->
  before ->
    unless fs.existsSync(tmpDir)
      fs.mkdirSync(tmpDir)

    fs.writeFileSync ttFile, """
    exports.config = (task) ->
      true
    exports.run = (task, log) ->
      true
    """

  after ->
    fs.unlinkSync(ttFile)

  it 'should be defined', ->
    expect(typeof tasks.route).to.be 'function'

  it 'should fail if task file does not exist', ->
    expect(tasks.route('nop', tmpDir)).to.be false

  it 'should route and execute the task', ->
    testTask = tasks.route('testtask', tmpDir)

    expect(testTask.config()).to.be true
    expect(testTask.run()).to.be true