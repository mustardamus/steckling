procrastdo.views.tasks_list = Backbone.View.extend
  events:
    'click #tasks-add': 'onAddTaskClick'

  initialize: ->
    @listenTo(@collection, 'add', @onTaskAdd)

  onTaskAdd: (task) ->
    taskEl = new procrastdo.views.tasks_item { model: task }
    $('ul', @$el).append taskEl.el #change that, no parent

  onAddTaskClick: ->
    procrastdo.routes.navigate 'tasks/new', { trigger: true }
    false