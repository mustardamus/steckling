$.mockjax
  url         : '/tasks'
  type        : 'POST'
  responseText:
    id   : 1
    title: 'test title post'

$.mockjax
  url         : '/tasks/1'
  type        : 'PUT'
  responseText:
    id   : 1
    title: 'test title put'

$.mockjax
  url         : '/tasks/2'
  type        : 'GET'
  responseText:
    id   : 2
    title: 'test title get'

$.mockjax
  url: '/tasks/3'
  type: 'DELETE'
  responseText:
    id: 3

describe 'task model', ->
  before ->
    @task = new procrastdo.models.task

  it 'should be defined', ->
    expect(_.isUndefined(@task)).to.be false

  it 'should have correct resource url', ->
    expect(@task.urlRoot).to.be '/tasks'

  it 'should have attributes', ->
    expect(_.isString(@task.attributes.title)).to.be true

  it 'should create the model', (done) ->
    tt = 'test title post'

    @task.save { title: tt },
      success: (task) ->
        expect(task.get('id')).to.be 1
        expect(task.get('title')).to.be tt

        done()

  it 'should update the model', (done) ->
    tt = 'test title put'

    @task.set 'id', 1
    @task.save { title: tt },
      success: (task) ->
        expect(task.get('title')).to.be tt
        done()

  it 'should fetch the model', (done) ->
    @task.set 'id', 2
    @task.fetch
      success: (task) ->
        expect(task.get('title')).to.be 'test title get'
        done()

  it 'should delete the model', (done) ->
    @task.set 'id', 3
    @task.destroy
      success: (task, res) ->
        expect(res.id).to.be 3
        done()