procrastdo.views.tasks_form = Backbone.View.extend
  template: """
    <li id="tasks-form">
      <form>
        <input type="text" id="task-title">
        <input type="submit" value="Save" class="btn">
      </form>
    </li>
  """

  events:
    'submit form': 'onFormSubmit'

  initialize: ->  
    @on 'show', =>
      $('#tasks-form', @$el).show()
      @inputEl.focus()

    @on 'hide', => $('#tasks-form', @$el).hide()

    @render()
    @inputEl = $('#task-title', @$el)

    @trigger 'hide'

  render: ->
    @$el.append Mustache.render(@template)

  onFormSubmit: ->
    taskTitle = @inputEl.val()
    
    if taskTitle.length
      task = new procrastdo.models.task { title: taskTitle }

      @collection.add task
      @trigger 'hide'
      $('#task-title', @$el).val ''
      procrastdo.routes.navigate '/'
    
    false