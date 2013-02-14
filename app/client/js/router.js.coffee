procrastdo.Router = Backbone.Router.extend
  initialize: ->
    @tasksCollection = new procrastdo.collections.tasks

  routes:
    ''              : 'homePage'
    'tasks'         : 'taskIndex'
    'tasks/new'     : 'taskNew'
    'tasks/:id'     : 'taskRead'
    'tasks/:id/edit': 'taskUpdate'
    'tasks/:id/destroy': 'taskDestroy'

  homePage: ->
    console.log 'client homepage route', @tasksCollection

  taskIndex: ->
    @tasksCollection.fetch
      success: =>
        console.log('task index', @tasksCollection.models)

  taskNew: ->
    task = new procrastdo.models.task { title: 'huha' }
    task.save
      success: =>
        console.log 'task saved', task

    console.log 'create new task', task

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