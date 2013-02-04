expect = require('expect.js')
fs     = require('fs')

rootDir = "#{__dirname}/../.."
tmpDir  = "#{rootDir}/tmp"
muteLog =
  info : ->
  error: ->

describe 'tasks routing', ->
  tasks  = require('../../lib/tasks')
  ttFile = "#{tmpDir}/testtask.coffee"

  before ->
    unless fs.existsSync(tmpDir)
      fs.mkdirSync(tmpDir)

    fs.writeFileSync ttFile, """
    exports.config = (t)    -> true
    exports.run    = (t, l) -> true
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

describe 'tasks', ->
  tasksDir = "#{rootDir}/tasks"
  
  describe 'new', ->
    newTask  = require("#{tasksDir}/new")
    taskMock = { thing: 'task', name : 'deleteme' }
    testFile = "#{tasksDir}/#{taskMock.name}.coffee"

    after ->
      fs.unlinkSync(testFile)

    it 'should be defined', ->
      expect(typeof newTask.config).to.be 'function'
      expect(typeof newTask.run).to.be 'function'

    it 'should create a new task template', ->
      newTask.run(taskMock, muteLog)

      expect(fs.existsSync(testFile)).to.be true