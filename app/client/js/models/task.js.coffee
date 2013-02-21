procrastdo.models.task = Backbone.Model.extend
  urlRoot : '/tasks'
  defaults:
    title: 'do something'

  initialize: ->
    #_.bindAll @, ''