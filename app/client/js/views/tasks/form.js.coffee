procrastdo.views.tasks_form = Backbone.View.extend
  template: """
    <li id="tasks-form">
      <form>
        <input type="text" id="task-title" autocomplete="off">
      </form>
    </li>
  """

  events:
    'submit form': 'onFormSubmit'

  initialize: ->  
    @on 'show', @onFormShow
    @on 'hide', @onFormHide

    @render()

    @formEl  = $('#tasks-form', @$el)
    @inputEl = $('#task-title', @$el)

    @trigger 'hide'

  render: ->
    @$el.append Mustache.render(@template)

  onFormShow: ->
    $('li.task-item-evening:first', @$el.parent()).before @formEl
    @formEl.show()
    @inputEl.focus()

  onFormHide: ->
    @formEl.hide()

  onFormSubmit: ->
    taskTitle = @inputEl.val()
    
    if taskTitle.length
      task = new procrastdo.models.task { title: taskTitle }

      task.save {},
        success: =>
          @collection.add task
          @trigger 'hide'
          @inputEl.val ''
          procrastdo.routes.navigate '/'
    else
      @trigger 'hide'
      procrastdo.routes.navigate '/'
    
    false