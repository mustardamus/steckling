procrastdo.models.sheet = Backbone.Model.extend
  urlRoot : '/sheets'
  defaults:
    tasks: []

  initialize: ->
    #_.bindAll @, ''