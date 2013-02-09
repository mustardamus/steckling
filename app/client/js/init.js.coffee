window.procrastdo =
  models     : {}
  views      : {}
  collections: {}  
  events     : {}
  routes     : {}

_.extend procrastdo.events, Backbone.Events

jQuery ->
  if procrastdo.Router
    procrastdo.routes = new procrastdo.Router
    Backbone.history.start()