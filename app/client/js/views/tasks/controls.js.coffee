procrastdo.views.tasks_controls = Backbone.View.extend
  events:
    'click #tasks-add': 'onAddTaskClick'

  initialize: ->
    
  onAddTaskClick: ->
    procrastdo.routes.navigate 'tasks/new', { trigger: true }
    false