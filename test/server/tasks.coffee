expect = require('expect.js')
tasks  = require('../../lib/tasks')

describe 'tasks routing', ->
  it 'should be defined', ->
    expect(typeof tasks.route).to.be 'function'