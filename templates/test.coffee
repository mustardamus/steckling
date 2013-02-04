# Mocha : http://visionmedia.github.com/mocha/
# Expect: https://github.com/LearnBoost/expect.js/

expect = require('expect.js')

describe 'thing to test', ->
  before ->      # run once before all tests
  after ->       # run once after all tests
  beforeEach ->  # run before each test
  afterEach ->   # run after each test

  it 'should do certain things', ->
    expect(true).to.be true