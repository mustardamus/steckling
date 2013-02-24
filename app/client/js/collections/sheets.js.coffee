procrastdo.collections.sheets = Backbone.Collection.extend
  url  : '/sheets'
  model: procrastdo.models.sheet
  
  initialize: ->
    