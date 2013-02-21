procrastdo.Router = Backbone.Router.extend
  initialize: ->
    @tasksCollection  = new procrastdo.collections.tasks
    @tasksFormView    = new procrastdo.views.tasks_form
      collection: @tasksCollection
      el        : '#tasks-list'
    @tasksListViewl   = new procrastdo.views.tasks_list
      collection: @tasksCollection
      el        : '#tasks-list'
    @taskControlsView = new procrastdo.views.tasks_controls
      el        : '#tasks-controls'

    @tasksCollection.fetch()

  routes:
    ''                 : 'homePage'
    'tasks'            : 'taskIndex'
    'tasks/new'        : 'taskNew'
    'tasks/:id'        : 'taskRead'
    'tasks/:id/edit'   : 'taskUpdate'
    'tasks/:id/destroy': 'taskDestroy'

  homePage: ->

  taskIndex: ->
    @tasksCollection.fetch
      success: =>
        console.log('task index', @tasksCollection.models)

  taskNew: ->
    @tasksFormView.trigger 'show'

  taskRead: (id) ->
    task = @tasksCollection.get(id)

    unless task
      task = new procrastdo.models.task { id: id }
      @tasksCollection.add(task)

    task.fetch
      success: ->
        console.log 'task get fetch', task
  
  taskUpdate: (id) ->
    task = new procrastdo.models.task { id: 4, title: 'gibbet' }
    task.set('title', 'new')
    task.save {},
      success: ->
        console.log 'task updated', task
      error: ->
        console.log 'error on save'

  taskDestroy: (id) ->
    task = @tasksCollection.get(id)

    unless task
      task = new procrastdo.models.task { id: id }
      @tasksCollection.add(task)

    task.destroy
      success: ->
        console.log 'task destroy', task