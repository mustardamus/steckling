procrastdo.Router = Backbone.Router.extend
  initialize: ->

  routes:
    '': 'homePage'

  homePage: ->
    console.log 'client homepage route'