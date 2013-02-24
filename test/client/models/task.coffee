describe 'task model', ->
  before ->
    @task = new procrastdo.models.task

  it 'should be defined', ->
    expect(_.isUndefined(@task)).to.be false

  it 'should have correct resource url', ->
    expect(@task.urlRoot).to.be '/tasks'

  it 'should have attributes', ->
    expect(_.isString(@task.attributes.title)).to.be true