procrastdo.views.tasks_list = Backbone.View.extend
  initialize: ->
    @listenTo(@collection, 'add', @onTaskAdd)
    @listenTo(@collection, 'reset', @onTasksReset)

  onTaskAdd: (task) ->
    taskEl = new procrastdo.views.tasks_item { model: task }

    $('li.task-item-evening:first', @$el).before taskEl.el

  onTasksReset: (collection) ->
    for task in collection.models
      taskView = new procrastdo.views.tasks_item { model: task }

      @$el.append taskView.el # insert after morning and normal tasks