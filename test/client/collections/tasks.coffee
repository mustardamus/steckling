$.mockjax
  url: '/tasks'
  type: 'GET'
  responseText: [
    { id: 1, title: 'task model 1' }
    { id: 2, title: 'task model 2' }
  ]

describe 'tasks collection', ->
  before ->
    @coll = new procrastdo.collections.tasks

  it 'should be defined', ->
    expect(_.isUndefined(@coll)).to.be false

  it 'should have correct resource url', ->
    expect(@coll.url).to.be '/tasks'

  it 'should have the correct model', ->
    model = new @coll.model
    expect(model.urlRoot).to.be '/tasks'

  it 'should add a model', ->
    model = new @coll.model { id: 1 }
    @coll.add model

    expect(@coll.models.length).to.be 1
    expect(@coll.models[0].id).to.be 1

  it 'should remove a model', ->
    model = new @coll.model { id: 1 }
    @coll.add model
    @coll.remove model

    expect(@coll.models.length).to.be 0

  it 'should fetch the models', (done) ->
    @coll.fetch
      success: (coll) ->
        expect(coll.models.length).to.be 2
        expect(coll.at(0).get('title')).to.be 'task model 1'
        done()