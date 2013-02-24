procrastdo.views.controls = Backbone.View.extend
  events:
    'click #tasks-add' : 'onAddTaskClick'
    'click #sheets-add': 'onAddSheetClick'

  initialize: ->
    
  onAddTaskClick: ->
    procrastdo.routes.navigate 'tasks/new', { trigger: true }
    false

  onAddSheetClick: ->
    procrastdo.routes.navigate 'sheets/new', { trigger: true }
    false