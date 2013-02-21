procrastdo.views.tasks_list = Backbone.View.extend
  initialize: ->
    @listenTo(@collection, 'add', @onTaskAdd)

  onTaskAdd: (task) ->
    taskEl = new procrastdo.views.tasks_item { model: task }

    $('li.task-item-evening:first', @$el).before taskEl.el