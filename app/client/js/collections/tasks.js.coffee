procrastdo.collections.tasks = Backbone.Collection.extend
  url  : '/tasks'
  model: procrastdo.models.task
  
  initialize: ->
    