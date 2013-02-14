procrastdo.models.task = Backbone.Model.extend
  urlRoot : '/tasks'
  defaults:
    title: 'default title'
    description: 'default description'

  initialize: ->
    #_.bindAll @, ''