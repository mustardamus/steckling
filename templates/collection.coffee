procrastdo.collections.COLL_NAME = Backbone.Collection.extend
  url  : '/COLL_NAME'
  model: procrastdo.models.task
  
  initialize: ->
    # todo: have a APP_NAME, and a singular COLL_NAME
    # init in lib/create.coffee