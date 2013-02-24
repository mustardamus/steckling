routes =
  'POST /tasks'    : { id: 1, title: 'title post' }
  'PUT /tasks/1'   : { id: 1, title: 'title put' }
  'GET /tasks/2'   : { id: 2, title: 'title get' }
  'DELETE /tasks/3': { id: 3 }

for route, data of routes
  r = route.split(' ')  
  $.mockjax { type: r[0], url: r[1], responseText: data }

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
    tt = routes['POST /tasks'].title

    @task.save { title: tt },
      success: (task) ->
        expect(task.get('id')).to.be 1
        expect(task.get('title')).to.be tt
        done()

  it 'should update the model', (done) ->
    tt = routes['PUT /tasks/1'].title

    @task.set 'id', 1
    @task.save { title: tt },
      success: (task) ->
        expect(task.get('title')).to.be tt
        done()

  it 'should fetch the model', (done) ->
    @task.set 'id', 2
    @task.fetch
      success: (task) ->
        expect(task.get('title')).to.be routes['GET /tasks/2'].title
        done()

  it 'should delete the model', (done) ->
    @task.set 'id', 3
    @task.destroy
      success: (task, res) ->
        expect(res.id).to.be 3
        done()